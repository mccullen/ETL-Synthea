IF OBJECT_ID('synthea_test.test_results', 'U') IS NOT NULL DROP TABLE synthea_test.test_results;
CREATE TABLE synthea_test.test_results (id INT, description VARCHAR(512), test VARCHAR(256), status VARCHAR(5));
-- 1: Drop patients with no gender, id is PERSON_SOURCE_VALUE
INSERT INTO synthea_test.test_results SELECT 1 AS id, 'Drop patients with no gender, id is PERSON_SOURCE_VALUE' AS description, 'Expect person' AS test, CASE WHEN (SELECT COUNT(*) FROM synthea_test.person WHERE person_source_value = '1') != 0 THEN 'FAIL' ELSE 'PASS' END AS status;
-- 2: Patient with unknown race has RACE_CONCEPT_ID = 0, id is PERSON_SOURCE_VALUE
INSERT INTO synthea_test.test_results SELECT 2 AS id, 'Patient with unknown race has RACE_CONCEPT_ID = 0, id is PERSON_SOURCE_VALUE' AS description, 'Expect person' AS test, CASE WHEN (SELECT COUNT(*) FROM synthea_test.person WHERE race_concept_id = '0' AND person_source_value = '2') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
-- 3: Patient with ethnicity other than hispanic has ETHNICITY_CONCEPT_ID = 0, id is PERSON_SOURCE_VALUE
INSERT INTO synthea_test.test_results SELECT 3 AS id, 'Patient with ethnicity other than hispanic has ETHNICITY_CONCEPT_ID = 0, id is PERSON_SOURCE_VALUE' AS description, 'Expect person' AS test, CASE WHEN (SELECT COUNT(*) FROM synthea_test.person WHERE ethnicity_concept_id = '0' AND person_source_value = '3') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
-- 6: ICD9 code in SNOMED column, CONDITION_CONCEPT_ID = 0
INSERT INTO synthea_test.test_results SELECT 6 AS id, 'ICD9 code in SNOMED column, CONDITION_CONCEPT_ID = 0' AS description, 'Expect condition_occurrence' AS test, CASE WHEN (SELECT COUNT(*) FROM synthea_test.condition_occurrence WHERE condition_concept_id = '0' AND condition_status_source_value = 'V89.03') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
-- 8: Test that observation period is taking the earliest start and latest stop, id is person_source_value
INSERT INTO synthea_test.test_results SELECT 8 AS id, 'Test that observation period is taking the earliest start and latest stop, id is person_source_value' AS description, 'Expect observation_period' AS test, CASE WHEN (SELECT COUNT(*) FROM synthea_test.observation_period WHERE observation_period_start_date = '2009-10-19' AND observation_period_end_date = '2009-11-30') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
-- 11: Collapse IP claim lines with <= 1 day between them, id is PERSON_SOURCE_VALUE
INSERT INTO synthea_test.test_results SELECT 11 AS id, 'Collapse IP claim lines with <= 1 day between them, id is PERSON_SOURCE_VALUE' AS description, 'Expect visit_occurrence' AS test, CASE WHEN (SELECT COUNT(*) FROM synthea_test.visit_occurrence WHERE visit_concept_id = '9201' AND visit_start_date = '2004-09-26' AND visit_end_date = '2004-09-30') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
-- 14: Collapse OP claims that occur within an IP visit, id is PERSON_SOURCE_VALUE
INSERT INTO synthea_test.test_results SELECT 14 AS id, 'Collapse OP claims that occur within an IP visit, id is PERSON_SOURCE_VALUE' AS description, 'Expect visit_occurrence' AS test, CASE WHEN (SELECT COUNT(*) FROM synthea_test.visit_occurrence WHERE visit_concept_id = '9201' AND visit_start_date = '2009-03-01' AND visit_end_date = '2009-03-04') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO synthea_test.test_results SELECT 14 AS id, 'Collapse OP claims that occur within an IP visit, id is PERSON_SOURCE_VALUE' AS description, 'Expect visit_occurrence' AS test, CASE WHEN (SELECT COUNT(*) FROM synthea_test.visit_occurrence WHERE visit_concept_id = '9202' AND visit_start_date = '2009-03-02') != 0 THEN 'FAIL' ELSE 'PASS' END AS status;
-- 17: ER visit occurs on the first day of the IP visit, two visits created, id is PERSON_SOURCE_VALUE
INSERT INTO synthea_test.test_results SELECT 17 AS id, 'ER visit occurs on the first day of the IP visit, two visits created, id is PERSON_SOURCE_VALUE' AS description, 'Expect visit_occurrence' AS test, CASE WHEN (SELECT COUNT(*) FROM synthea_test.visit_occurrence WHERE visit_concept_id = '9201' AND visit_start_date = '2010-05-01' AND visit_end_date = '2010-05-04') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO synthea_test.test_results SELECT 17 AS id, 'ER visit occurs on the first day of the IP visit, two visits created, id is PERSON_SOURCE_VALUE' AS description, 'Expect visit_occurrence' AS test, CASE WHEN (SELECT COUNT(*) FROM synthea_test.visit_occurrence WHERE visit_concept_id = '9203' AND visit_start_date = '2010-05-01' AND visit_end_date = '2010-05-01') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
-- 20: OP visit starts before IP visit but ends during IP, two visits created, id is PERSON_SOURCE_VALUE
INSERT INTO synthea_test.test_results SELECT 20 AS id, 'OP visit starts before IP visit but ends during IP, two visits created, id is PERSON_SOURCE_VALUE' AS description, 'Expect visit_occurrence' AS test, CASE WHEN (SELECT COUNT(*) FROM synthea_test.visit_occurrence WHERE visit_concept_id = '9201' AND visit_start_date = '1990-03-06' AND visit_end_date = '1990-03-08') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO synthea_test.test_results SELECT 20 AS id, 'OP visit starts before IP visit but ends during IP, two visits created, id is PERSON_SOURCE_VALUE' AS description, 'Expect visit_occurrence' AS test, CASE WHEN (SELECT COUNT(*) FROM synthea_test.visit_occurrence WHERE visit_concept_id = '9202' AND visit_start_date = '1990-03-05' AND visit_end_date = '1990-03-06') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
-- 23: Two ER visits start on the same day, one visit created, id is PERSON_SOURCE_VALUE
INSERT INTO synthea_test.test_results SELECT 23 AS id, 'Two ER visits start on the same day, one visit created, id is PERSON_SOURCE_VALUE' AS description, 'Expect visit_occurrence' AS test, CASE WHEN (SELECT COUNT(*) FROM synthea_test.visit_occurrence WHERE visit_concept_id = '9203' AND visit_start_date = '1994-11-24' AND visit_end_date = '1994-11-25') = 0 THEN 'FAIL' ELSE 'PASS' END AS status;
INSERT INTO synthea_test.test_results SELECT 23 AS id, 'Two ER visits start on the same day, one visit created, id is PERSON_SOURCE_VALUE' AS description, 'Expect visit_occurrence' AS test, CASE WHEN (SELECT COUNT(*) FROM synthea_test.visit_occurrence WHERE visit_concept_id = '9203' AND visit_start_date = '1994-11-24' AND visit_end_date = '1994-11-24') != 0 THEN 'FAIL' ELSE 'PASS' END AS status;