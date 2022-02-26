/*1*/
select distinct vendor_name
from vendors v
where v.vendor_id in 
	(select vendor_id
	from invoices i
    where vendor_id = i.vendor_id
    )
order by vendor_name;

/*2*/
select invoice_number, invoice_total
from invoices i
where payment_total >
	(select avg(payment_total)
    from invoices i
    where i.payment_total > 0 )
order by invoice_total desc;

/*3*/
select account_number,
	account_description
from general_ledger_accounts g
where not exists
	(select *
    from invoice_line_items
    where account_number = g.account_number)
order by account_number;

/*4*/
select v.vendor_name, i.invoice_id, l.invoice_sequence, l.line_item_amount 
from invoice_line_items l
	join invoices i
		on i.invoice_id = l.invoice_id 
	join vendors v
		on v.vendor_id = i.vendor_id
where i.invoice_id in (select invoice_id from invoice_line_items where invoice_sequence>1)
order by vendor_name, i.invoice_id, invoice_sequence;

/*5??????????unpaidinvoice?8?*/
select vendor_id, max(max_of_unpaid_invoices)
from (  select vendor_id, max(invoice_total-payment_total-credit_total) as max_of_unpaid_invoices
		from invoices i
        where payment_date is null
        group by vendor_id
	)t;
    
/*6*/
select t.vendor_name,t.vendor_city,t.vendor_state
from (select vendor_name, vendor_city, vendor_state
    from vendors 
    group by vendor_city, vendor_state
    having count(*) =1)t
order by vendor_state,vendor_city;

/*7??????????35?*/
select distinct vendor_name, invoice_number, invoice_date, invoice_total
from invoices i join vendors v
	on i.vendor_id=v.vendor_id
where invoice_date =
	(select min(invoice_date)
    from invoices
    where vendor_id=i.vendor_id)
order by vendor_name;

