-- Test a bug that previously checkpoint would collect prepared transactions
-- which are actually committed. If the commit prepare xlog is before
-- checkpoint.redo, after the segment reboot, there would always be an orphaned
-- (actually committed) prepared transaction in memory. That could lead to
-- various issues. e.g. dtx recovery would try to abort that and then cause
-- panic on the segment with message like "cannot abort transaction 3285003, it
-- was already committed (twophase.c:2205)".

create extension if not exists gp_inject_fault;
include: helpers/server_helpers.sql;

create table crash_foo(i int);

1: select gp_inject_fault('after_commit_prepared', 'suspend', dbid)
   from gp_segment_configuration where content=0 and role='p';
2&: insert into crash_foo select i from generate_series(1,10) i;
1: select gp_wait_until_triggered_fault('after_commit_prepared', 1, dbid)
   from gp_segment_configuration where role='p' and content = 0;

1: checkpoint;
1: select gp_inject_fault('after_commit_prepared', 'resume', dbid)
        from gp_segment_configuration where content=0 and role='p';
1: select gp_inject_fault('after_commit_prepared', 'reset', dbid)
        from gp_segment_configuration where content=0 and role='p';
2<:

-- Restart seg0.
SELECT pg_ctl(datadir, 'restart', 'immediate') FROM gp_segment_configuration WHERE role='p' AND content=0;
-- Ensure there is no prepared xacts in memory after rebooting, else the below
-- drop query would hang and after cluster rebooting, dtx recovery will cause
-- panic on seg0 due to "cannot abort transaction 3285003, it was already
-- committed (twophase.c:2205)" kind of message, when trying to abort the
-- orphaned prepared transactions collected from segments.
0U: select * from pg_prepared_xacts;

4: drop table crash_foo;
