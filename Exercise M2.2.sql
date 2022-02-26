/*1*/
select *
from vendors inner join invoices
on vendors.vendor_id=invoices.vendor_id;

/*2*/
select v.vendor_name as vendor_name,
		i.invoice_number as invoice_number,
        i.invoice_date as invoice_date,
        i.invoice_total-i.payment_total-credit_total as balance_due
from vendors v inner join invoices i
		on v.vendor_id=i.vendor_id
where i.invoice_total-i.payment_total-credit_total !=0;

/*3*/
select v.vendor_name,
		v.default_account_number as default_account,
        g.account_description as description
from vendors v inner join General_Ledger_Accounts g
		on v.default_account_number = g.account_number
order by g.account_description asc, v.vendor_name asc;

/*4*/
select v.vendor_name,
		i.invoice_date,
        i.invoice_number,
        l.invoice_sequence as li_sequence,
        l.line_item_amount as li_amount
from vendors v inner 
	join invoices i 
		on v.vendor_id=i.vendor_id
	join invoice_line_items l
		on i.invoice_id=l.invoice_id
order by v.vendor_name asc, i.invoice_date asc, i.invoice_number asc, l.invoice_sequence asc;

/*5*/
select v.vendor_id, v.vendor_name,
	concat(v.vendor_contact_first_name," ",v.vendor_contact_last_name)
from vendors v join vendors v1
	on v.vendor_contact_last_name = v1.vendor_contact_last_name
    and v.vendor_id != v1.vendor_id;
    
/*6*/
select g.account_number, g.account_description
from General_Ledger_Accounts g
	left outer join Invoice_Line_Items i
		on g.account_number=i.account_number
where invoice_id is null
order by g.account_number asc;

/*7*/
	select vendor_name, 
    (select case when vendor_state not like 'CA' then 'Outside CA' end)
    from vendors
    where vendor_state not like 'CA'
Union
	select vendor_name, vendor_state
    from vendors
    where vendor_state like 'CA'
    order by vendor_name asc