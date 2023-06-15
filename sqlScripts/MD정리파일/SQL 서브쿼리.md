## 서브쿼리(Subquery)
: 오라클에서 서브쿼리는 다른 쿼리 내에 포함된 쿼리로 주로 SELECT 문 내에서 사용됩니다. 서브쿼리는 외부 쿼리의 조건에 따라 결과를 동적으로 결정할 수 있는 강력한 도구입니다.

### 서브쿼리 사용하는 이유
+ 1. 데이터 필터링 : 서브쿼리를 사용하여 SELECT 문에서 데이터를 필터링할 수 있습니다. 예를 들어, 특정 조건을 만족하는 행만을 조회하고나 할 때 서브쿼리를 사용하여 조건을 정의하고 결과를 반환받을 수 있습니다.
+ 2. 데이터 비교 : 서브쿼리를 사용하여 데이터를 비교하고 값을 확인할 수 있습니다. 예를 들어, 서브쿼리를 사용하여 특정 열의 최댓값이나 최솟값을 찾거나, 다른 테이블과의 관계를 비교할 수 있습니다.
+ 3. 데이터 조작 : 서브쿼리를 사용하여 INSERT, UPDATE, DELETE 문 등에서 서브쿼리의 결과를 활용하여 데이터를 조작할 수 있습니다. 예를 들어, 다른 테이블의 조건을 만족하는 데이터를 삽입하거나, 서브쿼리의 결과에 따라 데이터를 업데이트할 수 있습니다.
+ 4. 데이터 집계 : 서브쿼리를 사용하여 데이터를 집계할 수 있습니다. 예를 들어, 서브쿼리를 사용하여 그룹화된 데이터의 합계, 평균, 개수 등을 계산할 수 있습니다.
----
### 서브쿼리 종류(SELECT)
+ 1. 단일 행 서브쿼리 (Single-row Subquery)
    + 단일 행 서브쿼리는 서브쿼리의 결과가 한 행을 반환하는 경우에 사용됩니다. 주로 비교 연산자와 함께 사용되어 단일 행 값을 반환하거나 비교하는데 활용됩니다.
    + 예시 : SELECT * FROM employees WHERE salary > (SELECT AVG(salary) FROM employees) 
+ 2. 다중 행 서브쿼리 (Multi-row Subquery)
    + 다중 행 서브쿼리는 서브쿼리의 결과가 여러 행을 반환하는 경우에 사용됩니다. IN, ANY, ALL 등의 연산자와 함께 사용되어 다중 행 값을 반환하거나 비교하는데 활용됩니다.
    + 예시 : SELECT * FROM employees WHERE department_id IN (SELECT department_id FROM departments WHERE location_id = 1700)
+ 3. 스칼라 서브쿼리 (Scalar Subquery)
    + 스칼라 서브쿼리는 서브쿼리의 결과가 단일 스칼라 값(단일 열, 단일 행)을 반환하는 경우에 사용됩니다. 주로 SELECT 문의 열 표현식이나 비교 연산자에서 활용됩니다.
    + 예시 : SELECT employee_name, (SELECT AVG(salary) FROM employees) AS avg_salary FROM employees
+ 4. 상관 서브쿼리 (Correlated Subquery)
    + 상관 서브쿼리는 외부 쿼리의 컬럼 값을 서브쿼리 내에서 참조하는 경우에 사용됩니다. 서브쿼리가 외부 쿼리의 각 행에 대해 반복 실행되며, 외부 쿼리와 상호작용하여 결과를 반환합니다.
    + 예시 : SELECT * FROM employees e WHERE salary > (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id)
+ 5. 인라인 뷰 (Inline View) 
    + 인라인 뷰는 서브쿼리를 FROM 절에서 사용하는 것으로, 서브쿼리의 결과를 가상의 테이블로 간주하여 외부 쿼리와 함께 쿼리할 수 있습니다.
    + 예시 : SELECT e.employee_name, d.department_name FROM (SELECT * FROM employees WHERE salary > 5000) e JOIN departments d ON e.department_id = d.department_id
    ----
### 서브쿼리 WHERE, HAVING, FROM 절에서 사용법
+ WHERE 절에서의 서브쿼리 : WHERE 절에서의 서브쿼리는 주로 데이터의 필터링에 사용됩니다.
    + 예시: SELECT * FROM employees WHERE salary > (SELECT AVG(salary) FROM employees)
+ HAVING 절에서의 서브쿼리 : HAVING 절에서의 서브쿼리는 GROUP BY 절과 함께 사용되며, 그룹화된 결과에 대한 조건을 지정할 때 사용됩니다.
    + 예시: SELECT department_id, AVG(salary) FROM employees GROUP BY department_id HAVING AVG(salary) > (SELECT AVG(salary) FROM employees)
+ FROM 절에서의 서브쿼리 (인라인 뷰) : FROM 절에서의 서브쿼리는 주로 인라인 뷰로 사용되며, 서브쿼리의 결과를 가상의 테이블로 취급하여 외부 쿼리와 함께 쿼리할 수 있습니다.
    + 예시: SELECT e.employee_name, d.department_name FROM (SELECT * FROM employees WHERE salary > 5000) e JOIN departments d ON e.department_id = d.department_id