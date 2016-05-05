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
<property-tagging-filter-config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.watch4net.com/APG/Filter/PropertyTaggingFilter" xsi:schemaLocation="http://www.watch4net.com/APG/Filter/PropertyTaggingFilter  property-tagging-filter-config.xsd">
    <refresh unit="minutes">15</refresh>
    <files>
        <!--Set LUNs with ismetam=1 to parttype=MetaMember-->
        <text-file path="conf/setmetamembers.csv">
            <accessor accessor-class="StaticAccessor">
                <parameter name="line">LUN,1,MetaMember</parameter>
            </accessor>
            <field-separator>,</field-separator>
            <default-symbol>**</default-symbol>
            <null-symbol>@@</null-symbol>
            <key-properties>
                <key-property delete-after-use="false" string-type="string">parttype</key-property>
                <key-property delete-after-use="false" string-type="string">ismetam</key-property>
            </key-properties>
            <new-properties>
                <new-property>parttype</new-property>
            </new-properties>
        </text-file>

        <!--Set 'isMapped' to 1 (true) if sgname exists and !N/A, otherwise set to 0 (false)-->
        <text-file path="conf/ismapped.csv">
            <field-separator>,</field-separator>
            <default-symbol>**</default-symbol>
            <null-symbol>@@</null-symbol>
            <key-properties>
                <key-property delete-after-use="false" string-type="string">parttype</key-property>
                <key-property delete-after-use="false" string-type="regex">sgname</key-property>
            </key-properties>
            <new-properties>
                <new-property>ismapped</new-property>
            </new-properties>
        </text-file>

        <!--Set 'isMasked' to 1 (true) if hasinit is present and not N/A else set to 0 (false)-->
        <text-file path="conf/ismasked.csv">
            <field-separator>,</field-separator>
            <default-symbol>**</default-symbol>
            <null-symbol>@@</null-symbol>
            <key-properties>
                <key-property delete-after-use="false" string-type="string">parttype</key-property>
                <key-property delete-after-use="false" string-type="regex">hasinit</key-property>
            </key-properties>
            <new-properties>
                <new-property>ismasked</new-property>
            </new-properties>
        </text-file>

        <!--Set 'hasLUN' to 1 if property "vols" has 1 or more characters for parttype RAID Group or Storage Pool-->
        <text-file path="conf/hasLUN.csv">
            <field-separator>,</field-separator>
            <default-symbol>**</default-symbol>
            <null-symbol>@@</null-symbol>
            <key-properties>
                <key-property delete-after-use="false" string-type="string">parttype</key-property>
                <key-property delete-after-use="false" string-type="string">vols</key-property>
                </key-properties>
            <new-properties>
                <new-property>haslun</new-property>
            </new-properties>
        </text-file>

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
                    SELECT distinct ?device ?parttype ?partid ?rootwwn ?rootarry ?rootlun ?purpose ?isused
                    WHERE {
                               {
                                # for both Local and Remote Replica
                                ?sv a srm:StorageVolume .
                                ?sv  srm:replicatedFrom+ ?srclun .
                                OPTIONAL {?srclun srm:replicatedFrom ?temp .}
                                filter (!bound (?temp))
                                ?sv srm:displayName ?partid .
                                ?sv srm:residesOnStorageArray /srm:displayName ?device .
                                ?srclun srm:volumeWWN ?rootwwn .
                                ?srclun srm:displayName ?rootlun .
                                ?srclun srm:residesOnStorageArray / srm:displayName ?rootarry .
                                BIND ("LUN" as ?parttype)
                                LET (?purpose := IF( (?device = ?rootarry), "Local Replica", "Remote Replica"))
                                ?srclun srm:isUsed ?isused .
                                ?sv srm:residesOnStorageArray ?array .
                                ?array srm:model "VNXBlock"^^&lt;http://www.w3.org/2001/XMLSchema#string&gt; .
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
                <key-property delete-after-use="false" string-type="string">partid</key-property>
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
		
        <!--Set 'purpose' to Primary or System Resource if it hasn't already been set to Local Replica;Remote Replica;Pool Contributor-->
        <text-file path="conf/Purpose-Tag.csv">
            <accessor accessor-class="StaticAccessor">
                <parameter name="line">LUN,NO,@@,Primary</parameter>
				<parameter name="line">LUN,YES,@@,System Resource</parameter>
            </accessor>
            <field-separator>,</field-separator>
            <default-symbol>**</default-symbol>
            <null-symbol>@@</null-symbol>
            <key-properties>
                <key-property delete-after-use="false" string-type="string">parttype</key-property>
                <key-property delete-after-use="false" string-type="string">private</key-property>
                <key-property delete-after-use="false" string-type="regex">purpose</key-property>
                </key-properties>
            <new-properties>
                <new-property>purpose</new-property>
            </new-properties>
        </text-file>

        <!--Set 'isfcache' for Pool-based LUNs-->
        <text-file path="conf/isfcache-PoolLUNs.csv">
            <accessor accessor-class="StaticAccessor">
                <parameter name="line">LUN,Storage Pool,1,1</parameter>
                <parameter name="line">LUN,Storage Pool,0,0</parameter>
                <parameter name="line">LUN,Storage Pool,@@,0</parameter>
            </accessor>
            <field-separator>,</field-separator>
            <default-symbol>**</default-symbol>
            <null-symbol>@@</null-symbol>
            <key-properties>
                <key-property delete-after-use="false" string-type="string">parttype</key-property>
                <key-property delete-after-use="false" string-type="string">dgtype</key-property>
                <key-property delete-after-use="false" string-type="string">hasfc</key-property>
                </key-properties>
            <new-properties>
                <new-property>isfcache</new-property>
            </new-properties>
        </text-file>

        <!--Set 'isfast' for Storage Pools to 1 if tiername (module) has 1 or more characters (not N/A)-->
        <text-file path="conf/isfast-StoragePool.csv">
            <accessor accessor-class="StaticAccessor">
                <parameter name="line">Storage Pool,Storage Pool,N/A,0</parameter>
                <parameter name="line">Storage Pool,Storage Pool,^(?!N\/A$).*,1</parameter>
                <parameter name="line">Storage Pool,Storage Pool,@@,0</parameter>
            </accessor>
            <field-separator>,</field-separator>
            <default-symbol>**</default-symbol>
            <null-symbol>@@</null-symbol>
            <key-properties>
                <key-property delete-after-use="false" string-type="string">parttype</key-property>
                <key-property delete-after-use="false" string-type="string">pooltype</key-property>
                <key-property delete-after-use="false" string-type="regex">module</key-property>
            </key-properties>
            <new-properties>
                <new-property>isfast</new-property>
            </new-properties>
        </text-file>

        <!--Set 'isfast' for thin LUNs to 1 if tiername(module) and polname have 1 or more characters-->
        <text-file path="conf/isfast-LUNs.csv">
            <accessor accessor-class="StaticAccessor">
                <parameter name="line">LUN,Thin,N/A,N/A,0</parameter>
                <parameter name="line">LUN,Thin,N/A,.+,0</parameter>
                <parameter name="line">LUN,Thin,.+,N/A,0</parameter>
                <parameter name="line">LUN,Thin,^(?!N\/A$).*,^(?!N\/A$).*,1</parameter>
                <parameter name="line">LUN,Thin,@@,.+,0</parameter>
                <parameter name="line">LUN,Thin,.+,@@,0</parameter>
                <parameter name="line">LUN,Thin,@@,@@,0</parameter>
            </accessor>
            <field-separator>,</field-separator>
            <default-symbol>**</default-symbol>
            <null-symbol>@@</null-symbol>
            <key-properties>
                <key-property delete-after-use="false" string-type="string">parttype</key-property>
                <key-property delete-after-use="false" string-type="string">dgstype</key-property>
                <key-property delete-after-use="false" string-type="regex">module</key-property>
                <key-property delete-after-use="false" string-type="regex">polname</key-property>
            </key-properties>
            <new-properties>
                <new-property>isfast</new-property>
            </new-properties>
        </text-file>

		<!--Create 'luntagid' by concatenating 'serialnb' and 'hexid' -->
		<text-file path="conf/concatenate_luntagid.csv">
			<accessor accessor-class="StaticAccessor">
				<parameter name="field-separator">,</parameter>
				<parameter name="field-quoting">"</parameter>
				<parameter name="line">VNXBlock-Collector,LUN,[serialnb]_[hexid]</parameter>
			</accessor>
			<field-separator>,</field-separator>
			<default-symbol>**</default-symbol>
			<property-insertion start="[" end="]" />
			<key-properties>
					<key-property delete-after-use="false" string-type="string">source</key-property>
					<key-property delete-after-use="false" string-type="string">parttype</key-property>
				</key-properties>
			<new-properties>
				<new-property>luntagid</new-property>
			</new-properties>
		</text-file>

        <!--Create 'feport' by concatenating 'memberof' and 'part' for Block-side PORT-->
        <text-file path="conf/concatenate_feport_BlockPort.csv">
            <accessor accessor-class="StaticAccessor">
                <parameter name="field-separator">,</parameter>
                <parameter name="field-quoting">"</parameter>
                <parameter name="line">VNXBlock-Collector,Port,[memberof]:[part]</parameter>
            </accessor>
            <field-separator>,</field-separator>
            <default-symbol>**</default-symbol>
            <property-insertion start="[" end="]" />
            <key-properties>
                <key-property delete-after-use="false" string-type="string">source</key-property>
                <key-property delete-after-use="false" string-type="string">parttype</key-property>
            </key-properties>
            <new-properties>
                <new-property>feport</new-property>
            </new-properties>
        </text-file>

    </files>
</property-tagging-filter-config>
