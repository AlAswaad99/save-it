begin;
select plan(1);

select ok(true, 'database test runner is wired');

select * from finish();
rollback;
