## Index on posts by user_id

### Before
`explain analyze select * from posts where user_id=6084;`

<pre>
                                                              QUERY PLAN                                                              
--------------------------------------------------------------------------------------------------------------------------------------
 Index Scan using index_posts_on_user_id on posts  (cost=0.42..58.35 rows=967 width=147) (actual time=0.258..4.643 rows=1000 loops=1)
   Index Cond: (user_id = 6084)
 Planning time: 6.414 ms
 Execution time: 4.811 ms
(4 rows)
</pre>

### After
`explain analyze select * from posts where user_id=6084;`

<pre>
                                                              QUERY PLAN                                                              
--------------------------------------------------------------------------------------------------------------------------------------
 Index Scan using index_posts_on_user_id on posts  (cost=0.42..58.35 rows=967 width=147) (actual time=0.040..0.517 rows=1000 loops=1)
   Index Cond: (user_id = 6084)
 Planning time: 0.869 ms
 Execution time: 0.627 ms
(4 rows)
</pre>

## Index on posts by created_at

### Before

`explain analyze SELECT "posts".* FROM "posts"  ORDER BY "posts"."created_at" DESC;`

<pre>
                                                       QUERY PLAN                                                        
-------------------------------------------------------------------------------------------------------------------------
 Sort  (cost=282138.84..284638.84 rows=1000000 width=147) (actual time=955.838..1129.186 rows=1000000 loops=1)
   Sort Key: created_at
   Sort Method: external merge  Disk: 157224kB
   ->  Seq Scan on posts  (cost=0.00..32086.00 rows=1000000 width=147) (actual time=0.014..114.301 rows=1000000 loops=1)
 Planning time: 0.084 ms
 Execution time: 1182.749 ms
(6 rows)
</pre>

### After

`explain analyze SELECT "posts".* FROM "posts"  ORDER BY "posts"."created_at" DESC;`

<pre>
                                                                          QUERY PLAN                                                                          
--------------------------------------------------------------------------------------------------------------------------------------------------------------
 Index Scan Backward using index_posts_on_created_at on posts  (cost=0.42..48069.43 rows=1000000 width=147) (actual time=0.020..231.796 rows=1000000 loops=1)
 Planning time: 0.558 ms
 Execution time: 261.678 ms
(3 rows)
</pre>
