/*select npi,nppes_provider_last_org_name, nppes_provider_street1
from public.prescriber
order by nppes_provider_last_org_name*/

--Question 1
--a. Which prescriber had the highest total number of claims (totaled over all drugs)? Report the npi and the total number of claims

select p2.npi,p2.nppes_provider_first_name, p2.nppes_provider_last_org_name,
SUM(p1.total_claim_count) as claims
from prescription as p1
left join prescriber as p2
on p1.npi = p2.npi
where p1.total_claim_count IS NOT NULL
group by p2.npi, p2.nppes_provider_first_name, p2.nppes_provider_last_org_name
order by claims DESC;

--b. Repeat the above, but this time report the nppes_provider_first_name, 
--nppes_provider_last_org_name, specialty_description, and the total number of claims.

select p2.npi,p2.nppes_provider_first_name, p2.nppes_provider_last_org_name,p2.specialty_description,
SUM(p1.total_claim_count) as claims
from prescription as p1
left join prescriber as p2
on p1.npi = p2.npi
where p1.total_claim_count IS NOT NULL
group by p2.npi, p2.nppes_provider_first_name, p2.nppes_provider_last_org_name, p2.specialty_description
order by claims DESC;

--question 2
--A. Which specialty had the most total number of claims (totaled over all drugs)?

select p2.npi,p2.specialty_description,
SUM(p1.total_claim_count) as claims
from prescription as p1
left join prescriber as p2
on p1.npi = p2.npi
where p1.total_claim_count IS NOT NULL
group by p2.npi, p2.specialty_description
order by claims DESC;

--B.Which specialty had the most total number of claims for opioids?

/*select *
from drug*/

select p2.specialty_description,
SUM(p1.total_claim_count) as claims
from prescription as p1
left join prescriber as p2
on p1.npi = p2.npi
join drug as d
on d.drug_name = p1.drug_name
where p1.total_claim_count IS NOT NULL
  opioid_drug_flag = 'Y',
  or long_actin_opioid_drug_flag = 'Y'
group by  p2.specialty_description
order by claims DESC;


