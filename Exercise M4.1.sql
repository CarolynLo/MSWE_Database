/*1??????????34?*/
select vendor_id, sum(invoice_total) as invoice_total
from invoices
group by vendor_id;

/*2*/
select v.vendor_name, sum(i.payment_total) as payment_total
from vendors v
	join invoices i
		on v.vendor_id = i.vendor_id
group by v.vendor_name
order by sum(i.payment_total) desc;
        
/*3*/
select v.vendor_name,
	count(*) as count_of_invoices,
    sum(i.invoice_total) as sum_of_invoice
from vendors v
	join invoices i
		on v.vendor_id=i.vendor_id
group by v.vendor_name
order by count(*) desc;

/*4*/
select g.account_description,
	count(*) as count_of_items,
    sum(i.line_item_amount) as sum_of_line_item_amount
from general_ledger_accounts g
	join Invoice_Line_Items i
		on g.account_number=i.account_number
group by account_description
having count(*) > 1
order by sum(i.line_item_amount) desc;

/*5*/
select g.account_description,
	count(*) as count_of_items,
    sum(i.line_item_amount) as sum_of_line_item_amount
from general_ledger_accounts g
	join Invoice_Line_Items i
		on g.account_number=i.account_number
	join Invoices inv
		on inv.invoice_id = i.invoice_id
where inv.invoice_date between '2018-04-01' and '2018-06-30'
group by account_description
having count(*) > 1
order by sum(i.line_item_amount) desc;

/*6*/
select account_number,
	sum(line_item_amount) as sum_of_line_items_amount
from invoice_line_items
group by account_number with rollup;

/*7*/
select vendor_name,
	count(distinct(ili.account_number)) as count_of_distinct_accounts
from vendors v
	join invoices i
		on v.vendor_id = i.vendor_id
	join invoice_line_items ili
		on ili.invoice_id= i.invoice_id
group by vendor_name
having count(distinct(ili.account_number)) >1;

/*8??????????40?*/
select if(grouping(terms_id)=1, 'terms_id', terms_id),
	if(grouping(vendor_id)=1, 'vendor_id', vendor_id)
	payment_date,
    sum(invoice_total-payment_total-credit_total) as sum_of_balance_due
from invoices
group by terms_id, vendor_id with rollup
