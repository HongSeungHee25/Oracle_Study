## <span style="color:pink">JOIN ~ ON (세트)</span>
: SQL의 JOIN 문은 둘 이상의 테이블을 연결하여 데이터를 검색하거나 조작하는 데 사용됩니다. </BR>JOIN 문은 특정 조건을 기반으로 테이블 간의 관계를 정의하고, 이를 통해 관련된 데이터를 한번에 조회할 수 있습니다. </BR>JOIN 문에서 사용되는 ON 절은 조인 조건을 지정하는 역할을 합니다. </BR>ON 절은 각 테이블의 열을 비교하고, 조건을 만족하는 행들을 결합합니다.</BR> ON 절은 JOIN 문의 일부로 사용됩니다.
+ **<span style="color:RED">SELECT</SPAN> 컬럼 <span style="color:RED">FROM </SPAN>테이블1 <span style="color:RED">JOIN</SPAN> 테이블2 <span style="color:RED">ON</SPAN> 조인조건**
    + *여기서 조인조건은 테이블 간의 연결 조건을 나타내는 식입니다. </BR>ON 절에서는 비교 연산자(=,<,> 등)와 논리 연산자(AND, OR)를 사용하여 조인 조건을 정의할 수 있습니다.*

### JOIN 문의 종류 - 내부 조인
+  **<span style="color:RED">INNER JOIN</SPAN>** : 두 테이블 간의 공통된 값을 가진 행들을 결합합니다.</BR> 조인 조건을 만족하는 행들만 결과에 포함합니다.
    + **<span style="color:RED">SELECT</SPAN> 컬럼 <span style="color:RED">FROM </SPAN>테이블1 <span style="color:RED">INNER JOIN</SPAN> 테이블2 <span style="color:RED">ON</SPAN> 조인조건**
    -----
### JOIN 문의 종류 - 외부 조인
+ 1. **<span style="color:RED">LEFT JOIN</SPAN>** : 왼쪽 테이블의 모든 행을 포함하고, 오른쪽 테이블의 조인 조건을 만족하는 행들을 결합합니다.</BR> 오른쪽 테이블의 값이 없는 경우 NULL 값으로 채워집니다.
    + **<span style="color:RED">SELECT</SPAN> 컬럼 <span style="color:RED">FROM </SPAN>테이블1 <span style="color:RED">LEFT JOIN</SPAN> 테이블2 <span style="color:RED">ON</SPAN> 조인조건**
    -----
+ 2. **<span style="color:RED">RIGHT JOIN</SPAN>** : 오른쪽 테이블의 모든 행을 포함하고, 왼쪽 테이블의 조인 조건을 만족하는 행들을 결합합니다.</BR> 왼쪽 테이블의 값이 없는 경우 NULL 값으로 채워집니다.
    + **<span style="color:RED">SELECT</SPAN> 컬럼 <span style="color:RED">FROM </SPAN>테이블1 <span style="color:RED">RIGHT JOIN</SPAN> 테이블2 <span style="color:RED">ON</SPAN> 조인조건**
    -----
+ 3. **<span style="color:RED">FULL JOIN</SPAN>** : 왼쪽과 오른쪽 테이블의 모든 행을 포함합니다. 조인 조건을 만족하는 행들이 결합되며, </BR>없는 값은 NULL 값으로 채워집니다.
    + **<span style="color:RED">SELECT</SPAN> 컬럼 <span style="color:RED">FROM </SPAN>테이블1 <span style="color:RED">FULL JOIN</SPAN> 테이블2 <span style="color:RED">ON</SPAN> 조인조건**

*JOIN 문은 테이블 간의 관계를 이해하고, 필요한 데이터를 효율적으로 가져오기 위해 중요한 기능입니다. </BR>올바른 조인 조건을 설정하고 필요한 결과를 얻기 위해 JOIN 문을 적절히 활용하는 것이 중요합니다.*

***JOIN 후에 조건식 검사를 할때 외부 조인에서는 "<span style="color:RED">WHERE</SPAN>"를 사용합니다.***
