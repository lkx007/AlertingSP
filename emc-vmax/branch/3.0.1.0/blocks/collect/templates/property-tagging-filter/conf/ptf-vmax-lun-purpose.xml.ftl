[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<!--
* Copyright (c) 2013 EMC Corporation
* All Rights Reserved
*
* This software contains the intellectual property of EMC Corporation
* or is licensed to EMC Corporation from third parties.  Use of this
* software and the intellectual property contained therein is expressly
* limited to the terms and conditions of the License Agreement under which
* it is provided by or on behalf of EMC.
-->
<property-tagging-filter-config xmlns="http://www.watch4net.com/APG/Filter/PropertyTaggingFilter"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.watch4net.com/APG/Filter/PropertyTaggingFilter  property-tagging-filter-config.xsd" >
    <refresh unit="minutes">60</refresh>
    <files>

[#if use_topo]
        <!-- Tag LUN Purpose based on Topology Service replica chain -->
        <text-file path="conf/replica-chain.csv" encoding="UTF-8">
            <accessor accessor-class="com.watch4net.apg.v2.collector.plugins.propertytaggingfilter.accessor.SparqlAccessor">
                <parameter name="url">https://${topologyservice.host}:${topologyservice.gateway.port}/Backends/Topology-Service/Default/topology/repository/sparql</parameter>
                <parameter name="user">${topologyservice.gateway.username}</parameter>
                <parameter name="password">${topologyservice.gateway.password}</parameter>
                <parameter name="disableSSLValidation">true</parameter>
                <parameter name="query">
                    PREFIX srm: &lt;http://ontologies.emc.com/2013/08/srm#&gt;
                    SELECT distinct ?device ?parttype ?part ?rootwwn ?rootarry ?rootlun ?purpose ?isused
                    WHERE {
                        {
                            ?sv a srm:StorageVolume .
                            ?sv  srm:replicatedFrom+ ?srclun .
                            OPTIONAL {?srclun srm:replicatedFrom ?temp .}
                            filter (!bound (?temp))
                            ?sv srm:displayName ?part .
                            ?sv srm:residesOnStorageArray /srm:displayName ?device .
                            ?srclun srm:volumeWWN ?rootwwn .
                            ?srclun srm:displayName ?rootlun .
                            ?srclun srm:residesOnStorageArray / srm:displayName ?rootarry .
                            BIND ("LUN" as ?parttype)
                            LET (?purpose := IF( (?device = ?rootarry), "Local Replica", "Remote Replica"))
                            ?srclun srm:isUsed ?isused .
                        } 
                        UNION {
                            ?sv a srm:StorageVolume .
                            ?sv srm:replicatedTo ?lr .
                            OPTIONAL {?sv srm:replicatedFrom ?temp .}
                            filter (!bound(?temp))
                            ?sv srm:displayName ?part .
                            ?sv srm:residesOnStorageArray /srm:displayName ?device .
                            ?sv srm:volumeWWN ?rootwwn .
                            ?sv srm:displayName ?rootlun .
                            ?sv srm:residesOnStorageArray / srm:displayName ?rootarry .
                            BIND ("LUN" as ?parttype)
                            LET (?purpose := IF( !bound(?purpose), "", ?purpose))
                            ?sv srm:isUsed ?isused .
                        }
                    }
                </parameter>
            </accessor>
            <field-separator>,</field-separator>
            <field-quoting>"</field-quoting>
            <default-symbol>**</default-symbol>
            <property-insertion start="[" end="]"/>
            <key-properties>
                <key-property delete-after-use="false" string-type="string">device</key-property>
                <key-property delete-after-use="false" string-type="string">parttype</key-property>
                <key-property delete-after-use="false" string-type="string">part</key-property>
            </key-properties>
            <new-properties>
                <new-property>rootwwn</new-property>
                <new-property>rootarry</new-property>
                <new-property>rootlun</new-property>
                <new-property>purpose</new-property>
                <new-property>isused</new-property>
            </new-properties>
        </text-file>
[/#if]


        <!-- Tag LUN with System Resource and Pool Contributor Purpose -->
        <text-file path="conf/SystemResourceLunPurpose.csv">
            <accessor accessor-class="StaticAccessor">
                <parameter name="field-separator">,</parameter>
                <parameter name="field-quoting">"</parameter>
                <!-- Using Capacity metric because its properties will get CRFed to ConsumedCapacity.
                     UsedCapacity will get Capacity/ConsumedCapacity properties via ICF. -->
                <!-- DRV -->
                <parameter name="line">Capacity,LUN,.*DRV.*,**,**,**,**,**,**,System Resource,1</parameter>
                
                <!-- VAULT -->
                <parameter name="line">Capacity,LUN,.*VAULT.*,**,**,**,**,**,**,System Resource,1</parameter>
                
                <!-- COVD -->
                <parameter name="line">Capacity,LUN,.*COVD.*,**,**,**,**,**,**,System Resource,1</parameter>
                
                <!-- SPARE -->
                <parameter name="line">Capacity,LUN,.*SPARE.*,**,**,**,**,**,**,System Resource,1</parameter>
                
                <!-- symfs = True -->
                <parameter name="line">Capacity,LUN,.*,True,**,**,**,**,**,System Resource,1</parameter>
                
                <!-- gatekpr = True -->
                <parameter name="line">Capacity,LUN,.*,**,True,**,**,**,**,System Resource,1</parameter>
                
                <!-- aclx = True -->
                <parameter name="line">Capacity,LUN,.*,**,**,True,**,**,**,System Resource,1</parameter>
                
                <!-- vcm = True -->
                <parameter name="line">Capacity,LUN,.*,**,**,**,True,**,**,System Resource,1</parameter>
                
                <!-- Pool Contributors -->
                <!-- savedev/datadev ispolctr=1 -->
                <parameter name="line">Capacity,LUN,.*,**,**,**,**,1,1,Pool Contributor,1</parameter>
                <parameter name="line">Capacity,LUN,.*,**,**,**,**,1,0,Pool Contributor,0</parameter>
            </accessor>
            <field-separator>,</field-separator>
            <default-symbol>**</default-symbol>
            <null-symbol>@@</null-symbol>
            <key-properties>
                <key-property delete-after-use="false" string-type="string">name</key-property>
                <key-property delete-after-use="false" string-type="string">parttype</key-property>
                <key-property delete-after-use="false" string-type="regex">config</key-property>
                <key-property delete-after-use="false" string-type="string">symfs</key-property>
                <key-property delete-after-use="false" string-type="string">gatekpr</key-property>
                <key-property delete-after-use="false" string-type="string">aclx</key-property>
                <key-property delete-after-use="false" string-type="string">vcm</key-property>
                <key-property delete-after-use="false" string-type="string">ispolctr</key-property>
                <key-property delete-after-use="false" string-type="string">ispcbnd</key-property>
            </key-properties>
            <new-properties>
                <new-property>purpose</new-property>
                <new-property>isused</new-property>
            </new-properties>
        </text-file>


        <!-- Tag LUN with Local Replica or Remote Replica, Purpose if Topology Service has not assigned purpose -->
        <text-file path="conf/TopoSvcLunPurpose.csv">
            <accessor accessor-class="StaticAccessor">
                <parameter name="field-separator">,</parameter>
                <parameter name="field-quoting">"</parameter>
                
                <!-- Using Capacity metric because its properties will get CRFed to ConsumedCapacity.
                     UsedCapacity will get Capacity/ConsumedCapacity properties via ICF. -->
                
                <!-- Local Replicas (BCV, VDEV) -->
                <!-- BCV or VDEV LUN that has no purpose property set by Topology Service and have both 
                     ismasked=1 and ismapped=1 will be considered as Primary LUN -->
                <parameter name="line">Capacity,LUN,.*BCV.*,0,0,@@,Local Replica</parameter>
                <parameter name="line">Capacity,LUN,.*BCV.*,1,0,@@,Local Replica</parameter>
                <parameter name="line">Capacity,LUN,.*BCV.*,0,1,@@,Local Replica</parameter>
                
                <parameter name="line">Capacity,LUN,.*VDEV.*,0,0,@@,Local Replica</parameter>
                <parameter name="line">Capacity,LUN,.*VDEV.*,1,0,@@,Local Replica</parameter>
                <parameter name="line">Capacity,LUN,.*VDEV.*,0,1,@@,Local Replica</parameter>
                
                <!-- Remote Replica (RDF1 = Local, RDF2 = Remote) -->
                <parameter name="line">Capacity,LUN,.*RDF2.*,0,0,@@,Remote Replica</parameter>
                <parameter name="line">Capacity,LUN,.*RDF2.*,1,0,@@,Remote Replica</parameter>
                <parameter name="line">Capacity,LUN,.*RDF2.*,0,1,@@,Remote Replica</parameter>
            </accessor>
            <field-separator>,</field-separator>
            <default-symbol>**</default-symbol>
            <null-symbol>@@</null-symbol>
            <key-properties>
                <key-property delete-after-use="false" string-type="regex">name</key-property>
                <key-property delete-after-use="false" string-type="string">parttype</key-property>
                <key-property delete-after-use="false" string-type="regex">config</key-property>
                <key-property delete-after-use="false" string-type="string">ismasked</key-property>
                <key-property delete-after-use="false" string-type="string">ismapped</key-property>
                <key-property delete-after-use="false" string-type="string">purpose</key-property>
            </key-properties>
            <new-properties>
                <new-property>purpose</new-property>
            </new-properties>
        </text-file>


        <!-- Tag LUN with Default Purpose of Primary -->
        <text-file path="conf/DefaultLunPurpose.csv">
            <accessor accessor-class="StaticAccessor">
                <parameter name="field-separator">,</parameter>
                <parameter name="field-quoting">"</parameter>
                
                <!-- Default to Primary -->
                <parameter name="line">Capacity,LUN,@@,Primary</parameter>
                
            </accessor>
            <field-separator>,</field-separator>
            <default-symbol>**</default-symbol>
            <null-symbol>@@</null-symbol>
            <key-properties>
                <key-property delete-after-use="false" string-type="regex">name</key-property>
                <key-property delete-after-use="false" string-type="string">parttype</key-property>
                <key-property delete-after-use="false" string-type="string">purpose</key-property>
            </key-properties>
            <new-properties>
                <new-property>purpose</new-property>
            </new-properties>
        </text-file>

    </files>
</property-tagging-filter-config>
