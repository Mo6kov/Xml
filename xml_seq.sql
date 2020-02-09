with demo4 as(
     select XMLType(
   '<master>
      <id>mater id</id>
      <details>
         <detail>
            <id>detail 1 id</id>
            <sub_details>
                <sub_detail>
                    <id>sub_detail 1.1 id</id>
                </sub_detail>
                <sub_detail>
                    <id>sub_detail 1.2 id</id>
                </sub_detail>
            </sub_details>
         </detail>
         <detail>
            <id>detail 2 id</id>
            <sub_details>
                <sub_detail>
                    <id>sub_detail 2.1 id</id>
                </sub_detail>
                <sub_detail>
                    <id>sub_detail 2.2 id</id>
                </sub_detail>
            </sub_details>
         </detail>
         <detail>
            <id>detail 3 id</id>
         </detail>
      </details>
   </master>'
            ) xml from dual)
   select extractValue(s.xml,'master/id') master_id
          ,extractValue(value(dtl),'detail/id') detail_id
          ,extractValue(value(subdtl),'sub_detail/id') sub_detail_id
   from demo4 s
        ,table(XMLSequence(s.xml.extract('master/details/detail'))) dtl
        ,table(XMLSequence(value(dtl).extract('detail/sub_details/sub_detail')))(+) subdtl;