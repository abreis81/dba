alter table rep_infoecf_out modify NUM_REINIC_OPER null;

alter table rep_infoecf_out modify NUM_REINIC_OPER default null;

update rep_infoecf_out set NUM_REINIC_OPER = 0 where NUM_REINIC_OPER is null;
commit;

@recompall