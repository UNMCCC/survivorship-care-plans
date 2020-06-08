/** Prompt table containts document names under Prompt Group of 'ESC7' */
--  Here are the codes for the SCPs as configured by our Mosaiq Apps
--      select distinct pgroup, Enum, text
--       from Prompt
--       where prompt.pgroup = 'ESC7' and prompt.text like '%SCP%' 
--       order by PGroup
-- Results in
--ESC7	2490	Breast SCP          
--ESC7	2491	Ovarian SCP         
--ESC7	2492	Vulvar SCP          
--ESC7	2493	Colorectal SCP      
--ESC7	2494	Endometrial SCP     
--ESC7	2495	Cervical SCP        
--ESC7	2496	Prostate SCP        
--
-- There is no date limits/ranges, pulls data regardless of date.
--
/*  Get all documents with SCP in the name (or could use Prompt.Enum/ object.docType)*/
SET NOCOUNT ON;
select DISTINCT
   QUOTENAME(dbo.fn_getPatientName(Object.Pat_ID1,'NAMELFM'),'"') as Name,
   Object.Account_ID as MRN,
   QUOTENAME(RTRIM(Prompt.Text),'"') as DocName,
   convert(char(10),Object.Encounter_DtTm,101) as encounter_date, -- MQ DataDict says "dictated" date time -- this seems to pre-date all other actions, including the REF
   QUOTENAME(dbo.fn_GetStaffName(Object.Dict_ID, 'NAMELFM'),'"') as dictated_by,
   convert(char(10),object.create_dtTm,101) as created_date,
   QUOTENAME(dbo.fn_GetStaffName(object.create_id, 'NameLFM'),'"') as Created_by,
   convert(char(10),object.Trans_dtTm,101) as transcribed_date, -- Transcribed date
   QUOTENAME(dbo.fn_GetStaffName(object.trans_id, 'NameLFM'),'"') as Transcribed_by,
   convert(char(10),Object.Sanct_DtTm,101) as Approved_date,
   QUOTENAME(dbo.fn_GetStaffName(object.sanct_id, 'NameLFM'),'"') as Approved_by,--
   convert(char(10),Orders.Create_DtTm,101) as SCPRef_order_created_on,
   QUOTENAME(dbo.fn_GetStaffName(Orders.Ord_Provider, 'NAMELFM'),'"') as SCPRef_Order_by,
   CASE 
      when Object.Status_Enum = 0 then 'Unknown'
      when Object.status_enum = 1 then 'Void'
      when Object.Status_Enum = 2 then 'Close'
      when Object.Status_Enum = 3 then 'Complete'
      when Object.Status_Enum = 4 then 'Hold'
      when Object.Status_Enum = 5 then 'Approve'
      when Object.Status_Enum = 6 then 'ProcessLock'
      when Object.Status_Enum = 7 then 'Pending'
      when Object.Status_Enum = 10 then 'ObjTranscriptionReq'  
      when Object.Status_Enum = 11 then 'ObjDictationReq' 
      when Object.Status_Enum = 12 then 'ObjEditReq'
      when Object.Status_Enum = 13 then 'ObjReviewReq'
      when Object.Status_Enum = 14 then 'ObjSignatureReq'
      when Object.Status_Enum = 16 then 'Unreviewed'  
      when Object.Status_Enum = 17 then 'Reviewed'
      when Object.Status_Enum = 20 then 'PartialApproval'
    END Object_Status
--     Object.ConfirmReqd_Flag,  -- flag indicating record has been approved and can be Read Confirmed
FROM dbo.Object 
INNER JOIN dbo.prompt on Prompt.enum = object.DocType 
LEFT  JOIN PNP on object.cc1 = pnp.pnp_id
INNER JOIN dbo.Orders on object.pat_id1 = Orders.pat_id1
INNER JOIN dbo.ObsReq ON Orders.ORC_Set_ID=ObsReq.ORC_Set_ID
INNER JOIN dbo.CPT  ON ObsReq.Hsp_Code=CPT.Hsp_Code

WHERE prompt.pgroup = 'ESC7' and prompt.text like '%SCP%'   -- Prompt Text = Name of document
  AND CPT.HSP_Code like '%Surv%'
  AND Object.Pat_ID1 <> 11526 -- sample 
  AND Orders.version = 0

