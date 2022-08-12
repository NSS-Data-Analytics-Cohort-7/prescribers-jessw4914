/*select npi,nppes_provider_last_org_name, nppes_provider_street1
from public.prescriber
order by nppes_provider_last_org_name*/

select p2.npi,p2.nppes_provider_first_name, p2.nppes_provider_last_org_name,
SUM(p1.total_claim_count) as claims
from prescription as p1
left join prescriber as p2
on p1.npi = p2.npi
where p1.total_claim_count IS NOT NULL
group by p2.npi, p2.nppes_provider_first_name, p2.nppes_provider_last_org_name
order by claims DESC;



