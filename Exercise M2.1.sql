/*8*/
SELECT vendor_name, vendor_contact_last_name, vendor_contact_first_name
FROM vendors
order by vendor_contact_last_name asc, vendor_contact_first_name asc;

/*9*/
Select   concat(vendor_contact_last_name,", ",vendor_contact_first_name)as full_name
From vendors
where vendor_contact_last_name like 'A%'
	or vendor_contact_last_name like 'B%'
    or vendor_contact_last_name like 'C%'
    or vendor_contact_last_name like 'E%'
order by vendor_contact_last_name asc, vendor_contact_first_name asc;

/*10*/
Select invoice_due_date as 'Due Date',
		invoice_total as 'Invoice Total',
        0.1*invoice_total as '10%',
        1.1*invoice_total as 'Plus 10%'
From invoices
Where invoice_total >=500
	and invoice_total <=1000
order by invoice_due_date desc;

/*11*/
Select invoice_number, invoice_total,
		payment_total+credit_total as 'payment_credit_total',
        invoice_total-payment_total-credit_total as balance_due
from invoices
where invoice_total-payment_total-credit_total > 50
order by invoice_total-payment_total-credit_total desc
limit 5;

/*12*/
Select invoice_number,invoice_date,
		invoice_total-payment_total-credit_total as balance_due,
        payment_date
From invoices
where payment_date is null;

/*13*/
SELECT DATE_FORMAT(current_date(), "%m-%d-%Y") as 'current_date';

/*14*/
select 50000 AS Starting_principal,
		(0.065* (select starting_principal ) )AS Interest,
		(select starting_principal)+( select interest) AS Principal_plus_interest;
        
