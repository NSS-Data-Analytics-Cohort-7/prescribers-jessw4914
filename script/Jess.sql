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
left join drug as d
on d.drug_name = p1.drug_name
where 
  d.opioid_drug_flag  = 'Y'
  or d.long_acting_opioid_drug_flag = 'Y'
group by  p2.specialty_description
order by claims DESC;


--C Challenge Question: Are there any specialties that appear in the prescriber table that 
--have no associated prescriptions in the prescription table?
-- there is np provider who has not prescribed medication
select distinct p2.specialty_description,
p1.total_claim_count as claims
from prescriber as p2
left join  prescription as p1
on p2.npi = p1.npi

where 
  p1.total_claim_count IS NULL;

--3. a. Which drug (generic_name) had the highest total drug cost?

select d.generic_name,
sum(total_drug_cost) as cost
from public.prescription as p1
INNER join public.drug as d
on p1.drug_name = d.drug_name
group by d.generic_name
order by cost DESC

--B. b. Which drug (generic_name) has the hightest total cost per day? 
--**Bonus: Round your cost per day column to 2 decimal places. Google ROUND to see how this works.

LEVOTHYROXINE SODIUM

select d.generic_name,
p1.total_day_supply_ge65 as cost
from public.prescription as p1
INNER join public.drug as d
on p1.drug_name = d.drug_name
WHERE total_day_supply_ge65 IS NOT NULL
group by d.generic_name, p1.total_day_supply_ge65
order by cost DESC


--4.a. For each drug in the drug table, return the drug name and then a column named 'drug_type' 
which says 'opioid' for drugs which have opioid_drug_flag = 'Y', says 'antibiotic' for those drugs 
which have antibiotic_drug_flag = 'Y', and says 'neither' for all other drugs.


SELECT drug_name,
CASE WHEN (opioid_drug_flag='Y') then 'opiod'
WHEN(antibiotic_drug_flag = 'y') then 'antibiotic'
ELSE 'neither'
END AS drug_type
from drug



--B. Building off of the query you wrote for part a, determine whether more was spent (total_drug_cost) 
--on opioids or on antibiotics. Hint: Format the total costs as MONEY for easier comparision.

SELECT d.drug_name,
CASE WHEN (opioid_drug_flag='Y') then 'opiod'
WHEN(antibiotic_drug_flag = 'y') then 'antibiotic'
ELSE 'NEITHER'
END AS drug_type,total_drug_cost
from drug as d
left join prescription as p
on d.drug_name=p.drug_name





--sanity check
select opioid_drug_flag
from drug
where opioid_drug_flag = 'Y'































