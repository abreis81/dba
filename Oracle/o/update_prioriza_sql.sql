---------------------------------------------------------------------------------------------------------------------
Update schedule_queue set priority = 1, state_id = 4, try_num  = 1 where state_id not in (3,5) and prod_id  in (201);
COMMIT;

Update schedule_queue set priority = 1, state_id = 4, try_num  = 1 where state_id not in (3,5) and prod_id  in (202);
COMMIT;

Update schedule_queue set priority = 1, state_id = 4, try_num  = 1 where state_id not in (3,5) and prod_id  in (203);
COMMIT;

Update schedule_queue set priority = 1, state_id = 4, try_num  = 1 where state_id not in (3,5) and prod_id  in (204);
COMMIT;

Update schedule_queue set priority = 1, state_id = 4, try_num  = 1 where state_id not in (3,5) and prod_id  in
(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,201,
202,203,401,601,501,204,27,402,403,502,503,504,505,506,507,450,460,508,28,
205,206,31,603,602,29,32,33,34,218,219,35,211,212,509,701,702,703,704,705,36,750,751,752,753);
COMMIT;
-----------------------------------------------------------------------------------------------------------------------
RV3-3 
  
Update schedule_queue set priority = 1, state_id = 4, try_num  = 1 where state_id not in (3,5) and prod_id  in
( 1, 2, 3, 4, 5 ,6, 7, 8, 9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,201,202,203,
401,601,218,204,27,402,403,219,35,211,212,450,460,28,205,206,31,603,602, 29, 32,33, 34,501,
502,503,504,505,506,507,508,509,701,702,703,704,705,750,751,752,36,706,511);
COMMIT;
------------------------------------------------------------------------------------------------------------------------
warning this process is in emergence case!!! ( So Com Autorização Norival )

Update schedule_queue set state_id = 40 where state_id not in (3,5) and prod_id  in
(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,
201,202,203,401,601,501,204,27,402,403,502,503,504,
505,506,507,450,460,508,28,205,206,31,603,602,29,32,33,34,218,219,35,
211,212,509,701,702,703,704,705,36);
COMMIT;  
-----------------------------------------------------------------------------------------------------------------------  
Ramal Laboratio ( 6995 )  

Update schedule_queue set priority = 1, state_id = 4, try_num  = 1 where state_id not in (3,5) and prod_id  in (218,219);
COMMIT;

Update schedule_queue set priority = 1, state_id = 4, try_num  = 1 where state_id not in (3,5) and prod_id  in (204);
COMMIT;
-------------------------------------------------------------------------------------------------------------------------