SELECT dtl.request      request
             ,dtl.invoice      invoice_parent
             ,dtl.invoice_line invoice_line_parent
             ,d.item           item
             ,dtl.unit_cost    unit_cost
             ,dtl.unit_measure unit_measure
         FROM sale_hdr           sh
             ,sale_dtl           d
             ,request_hdr_nvpair rn
             ,invoice_dtl        dtl
             ,invoice_hdr        hdr
        WHERE sh.sale = 729232--L_sale
          AND d.sale = sh.sale
          AND sh.sale_ref = rn.nv_value_string
          AND rn.request = dtl.request
          AND hdr.invoice = dtl.invoice
          AND hdr.invoice_type = 'SALE'
          AND d.line_no = dtl.line_no
          AND nv_attrib = 'RA_CUSTOMER_ORDER';
          
          
          SELECT * FROM integration_message WHERE integ_msg_ref = '870294'; 
          SELECT * FROM INVOICE_HDR WHERE INVOICE IN (958897
                                    ,962134
                                    ,962403
                                    ,961638
                                    ,960527
                                    ,962136
                                    ,961635
                                    ,961634
                                    ,961637
                                    ,961636
                                    ,961639); 
          SELECT * FROM system_log_hdr WHERE log_ref = '895836' ORDER BY 1 DESC; 
          SELECT * FROM INVOICE_DTL WHERE INVOICE = 958897; 
          SELECT * FROM sale_hdr WHERE sale = 729232; 
          SELECT * FROM sale_dtl WHERE sale = 729232;
          SELECT * FROM request_hdr_nvpair WHERE REQUEST = 676473;
          
          SELECT * FROM integration_message WHERE integ_msg_ref = '233879930'; --sale_ref da sale_dtl
          
          SELECT * FROM invoice_hdr_nvpair WHERE invoice = 958897; 
 



SELECT * FROM request_hdr WHERE request = 691498;
SELECT * FROM request_dtl WHERE request = 691498;
SELECT *
  FROM invoice_dtl a
      ,invoice_hdr b
 WHERE request = 742249
   AND a.invoice = b.invoice;

SELECT * FROM VW_APEX_INVOICE_DTL_ITEM WHERE invoice = 870294; 

	SELECT ih.invoice, id.LINE_NO, count(*)
	FROM INVOICE_HDR ih
	JOIN INVOICE_DTL id
	ON ih.INVOICE = id.INVOICE
	WHERE INVOICE_TYPE = 'RSALE'
	AND   INV_STATUS = 'NE'
	GROUP BY ih.invoice, id.LINE_NO
	HAVING  count(*) > 1;



-- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND 
-- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND 
-- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND 
-- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND 
-- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND 
-- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND 
-- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND -- WORKAROUND 

  
  SELECT invoice
    FROM invoice_dtl
   WHERE invoice IN (SELECT ih.invoice
                       FROM invoice_hdr ih
                       JOIN invoice_dtl id
                         ON ih.invoice = id.invoice
                      WHERE invoice_type = 'RSALE'
                        AND inv_status = 'NE'
                      GROUP BY ih.invoice
                              ,id.line_no
                     HAVING COUNT(*) > 1);
                     
                     
                     --DELETE from table a where rowid > (select min (rowid) from table b where a.coluna = b.coluna);
                     
                     SELECT * FROM INVOICE_dtl WHERE INVOICE IN (895836
                                                 ,900873
                                                 ,927299
                                                 ,908664
                                                 ,953056
                                                 ,923699
                                                 ,897252
                                                 ,912962
                                                 ,916541
                                                 ,888195
                                                 ,903392
                                                 ,888194
                                                 ,919050
                                                 ,900871
                                                 ,887985
                                                 ,908062
                                                 ,881034
                                                 ,957725
                                                 ,934049
                                                 ,908058
                                                 ,870294
                                                 ,928543
                                                 ,878031
                                                 ,928646
                                                 ,951142
                                                 ,944785
                                                 ,952939
                                                 ,955158
                                                 ,923776
                                                 ,903636
                                                 ,953063
                                                 ,956149
                                                 ,925466
                                                 ,923780
                                                 ,939727
                                                 ,931273
                                                 ,944789
                                                 ,934051
                                                 ,947142
                                                 ,919049
                                                 ,890850
                                                 ,929678
                                                 ,890869
                                                 ,924624
                                                 ,890866
                                                 ,952987
                                                 ,915849
                                                 ,938356
                                                 ,899668
                                                 ,953748
                                                 ,944658
                                                 ,913432
                                                 ,935989
                                                 ,884631
                                                 ,955426
                                                 ,941627
                                                 ,949956
                                                 ,955436
                                                 ,914568
                                                 ,919502
                                                 ,896958
                                                 ,955162
                                                 ,890697
                                                 ,919043
                                                 ,920125
                                                 ,935655
                                                 ,941537
                                                 ,950600
                                                 ,925156
                                                 ,942182
                                                 ,900898
                                                 ,944366
                                                 ,919328
                                                 ,890789
                                                 ,916653
                                                 ,922731
                                                 ,919042
                                                 ,929568
                                                 ,908634
                                                 ,900875
                                                 ,904172
                                                 ,957722
                                                 ,943774
                                                 ,923777
                                                 ,947334
                                                 ,904174
                                                 ,954101
                                                 ,942188
                                                 ,908635
                                                 ,881035
                                                 ,955164
                                                 ,955007
                                                 ,872270
                                                 ,934050
                                                 ,908637
                                                 ,907298
                                                 ,939725
                                                 ,949957
                                                 ,894882
                                                 ,939292
                                                 ,900896
                                                 ,923952
                                                 ,943195
                                                 ,920146
                                                 ,900960
                                                 ,915071
                                                 ,914567
                                                 ,890790
                                                 ,890846
                                                 ,934678
                                                 ,942183
                                                 ,890513
                                                 ,884302
                                                 ,903407
                                                 ,915295
                                                 ,958007
                                                 ,928645
                                                 ,953062
                                                 ,900876
                                                 ,876885
                                                 ,923779
                                                 ,936394
                                                 ,895029
                                                 ,931650
                                                 ,948452
                                                 ,924410
                                                 ,954651
                                                 ,900891
                                                 ,903410
                                                 ,918130
                                                 ,895838
                                                 ,948243
                                                 ,900870
                                                 ,927542
                                                 ,890860
                                                 ,915261
                                                 ,895039
                                                 ,900911
                                                 ,951143
                                                 ,916560
                                                 ,932285
                                                 ,914632
                                                 ,943337
                                                 ,900894
                                                 ,952069
                                                 ,914361
                                                 ,924625
                                                 ,908636
                                                 ,919048
                                                 ,908100
                                                 ,907512
                                                 ,948419
                                                 ,950262
                                                 ,913210
                                                 ,899827
                                                 ,919334
                                                 ,908099
                                                 ,890734
                                                 ,939291
                                                 ,924661
                                                 ,938357
                                                 ,890840
                                                 ,890486
                                                 ,928544
                                                 ,903403
                                                 ,894822
                                                 ,949482
                                                 ,879258
                                                 ,903397
                                                 ,894823
                                                 ,903398
                                                 ,931745
                                                 ,890854
                                                 ,939104
                                                 ,939102
                                                 ,890786
                                                 ,957721
                                                 ,949589
                                                 ,938355
                                                 ,929164
                                                 ,950794
                                                 ,913214
                                                 ,900895
                                                 ,890863
                                                 ,895837
                                                 ,941626
                                                 ,954055
                                                 ,954104
                                                 ,887197
                                                 ,941538
                                                 ,888049
                                                 ,884199
                                                 ,903391
                                                 ,900866
                                                 ,954056
                                                 ,941536
                                                 ,913335
                                                 ,900941); 
                     
DELETE FROM invoice_dtl a
 WHERE ROWID > (SELECT MIN(ROWID)
                  FROM invoice_dtl b
                 WHERE a.invoice = b.invoice
                   AND a.invoice IN (958897
                                    ,962134
                                    ,962403
                                    ,961638
                                    ,960527
                                    ,962136
                                    ,961635
                                    ,961634
                                    ,961637
                                    ,961636
                                    ,961639));
                                                 
                                                 
                                                 
DELETE distinct
    FROM invoice_dtl
   WHERE invoice IN (SELECT ih.invoice
                       FROM invoice_hdr ih
                       JOIN invoice_dtl id
                         ON ih.invoice = id.invoice
                      WHERE invoice_type = 'RSALE'
                        AND inv_status = 'NE'
                      GROUP BY ih.invoice
                              ,id.line_no
                     HAVING COUNT(*) > 1);
