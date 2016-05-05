[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<!--
* Copyright (c) 2013-2014 EMC Corporation
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
		<!-- Applicable to Block -->
		<text-file path="conf/rename_variableid.csv">
			<accessor accessor-class="StaticAccessor">
				<parameter name="field-separator">,</parameter>
				<parameter name="field-quoting">"</parameter>
				<parameter name="line">Block,Disk,[datagrp][serialnb][parttype][part][partid][memberof][portid][partsn][name]</parameter>
				<parameter name="line">Block,LUN,[datagrp][serialnb][parttype][part][partid][memberof][portid][partsn][name]</parameter>
				<parameter name="line">Block,**,[datagrp][serialnb][parttype][part][partid][memberof][portid][partsn][dgraid][dgname][name]</parameter>
			</accessor>
			<field-separator>,</field-separator>
			<default-symbol>**</default-symbol>
			<property-insertion start="[" end="]" />
			<key-properties>
				<key-property delete-after-use="false" string-type="string">datatype</key-property>
				<key-property delete-after-use="false" string-type="string">parttype</key-property>
			</key-properties>
			<new-properties>
				<new-property>RV_Variable</new-property>
			</new-properties>
		</text-file>
		<!-- Applicable to Block -->
		<text-file path="conf/set-uid.csv">
			<accessor accessor-class="StaticAccessor">
				<parameter name="field-separator">,</parameter>
				<parameter name="field-quoting">"</parameter>
				<parameter name="line">Block,[partsn]</parameter>
			</accessor>
			<field-separator>,</field-separator>
			<default-symbol>**</default-symbol>
			<property-insertion start="[" end="]" />
			<key-properties>
				<key-property delete-after-use="false" string-type="string">datatype</key-property>
			</key-properties>
			<new-properties>
				<new-property>uid</new-property>
			</new-properties>
		</text-file>
		<!-- Applicable to Block. TODO- add VNXe models -->
		<text-file path="conf/vnx_models.csv">
			<field-separator>,</field-separator>
			<default-symbol>**</default-symbol>
			<key-properties>
				<key-property delete-after-use="false" string-type="string">datatype</key-property>
				<key-property delete-after-use="false" string-type="regex">model</key-property>
			</key-properties>
			<new-properties>
				<new-property>maxdisk</new-property>
				<new-property>maxhost</new-property>
			</new-properties>
		</text-file>
		<!-- Applies to classic block vnx.  Vnxe gets rpm at the collection. -->
		<text-file path="conf/hd_rpm.csv">
			<field-separator>,</field-separator>
			<default-symbol>**</default-symbol>
			<key-properties>
				<key-property delete-after-use="false" string-type="string">source</key-property>
				<key-property delete-after-use="false" string-type="regex">partmdl</key-property>
			</key-properties>
			<new-properties>
				<new-property>diskrpm</new-property>
			</new-properties>
		</text-file>
		<!-- Applicable to Block -->
		<text-file path="conf/hd_factors.csv">
			<field-separator>,</field-separator>
			<default-symbol>**</default-symbol>
			<key-properties>
				<key-property delete-after-use="false" string-type="string">datatype</key-property>
				<key-property delete-after-use="false" string-type="string">diskrpm</key-property>
				<key-property delete-after-use="false" string-type="string">disktype</key-property>
			</key-properties>
			<new-properties>
				<new-property>partmax</new-property>
				<new-property>seektime</new-property>
			</new-properties>
		</text-file>
		<!-- Applicable to Block -->
		<text-file path="conf/disk_cost_per_gigabyte.csv">
			<field-separator>,</field-separator>
			<default-symbol>**</default-symbol>
			<key-properties>
				<key-property delete-after-use="false" string-type="string">datatype</key-property>
				<key-property delete-after-use="false" string-type="regex">model</key-property>
				<key-property delete-after-use="false" string-type="string">dgraid</key-property>
				<key-property delete-after-use="false" string-type="string">tiername</key-property>
			</key-properties>
			<new-properties>
				<new-property>cost</new-property>
			</new-properties>
		</text-file>
		<!-- Applicable to Block -->
		<text-file path="conf/business_unit.csv">
			<field-separator>,</field-separator>
			<field-quoting>"</field-quoting>
			<default-symbol>**</default-symbol>
			<null-symbol>@@</null-symbol>
			<key-properties>
				<key-property delete-after-use="false" string-type="string">datatype</key-property>
				<key-property delete-after-use="false" string-type="string">device</key-property>
				<key-property delete-after-use="false" string-type="regex">part</key-property>
			</key-properties>
			<new-properties>
				<new-property>bunit</new-property>
				<new-property>appname</new-property>
				<new-property>appowner</new-property>
			</new-properties>
		</text-file>
		<!-- Applies to classic block vnx.  Vnxe gets module and tiername at the collection. -->
		<text-file path="conf/moduletotier.csv">
			<field-separator>,</field-separator>
			<default-symbol>**</default-symbol>
			<key-properties>
				<key-property delete-after-use="false" string-type="string">source</key-property>
				<key-property delete-after-use="false" string-type="string">module</key-property>
			</key-properties>
			<new-properties>
				<new-property>tiername</new-property>
			</new-properties>
		</text-file>
		[#if use_topo]
		<!-- Tag LUN Purpose based on Topology Service replica chain.  N/A for KH -->
        <text-file path="conf/pre-replica-chain.csv" encoding="UTF-8">
            <accessor accessor-class="com.watch4net.apg.v2.collector.plugins.propertytaggingfilter.accessor.SparqlAccessor">
                <parameter name="url">https://${topologyservice.host}:${topologyservice.gateway.port}/Backends/Topology-Service/Default/topology/repository/sparql</parameter>
                <parameter name="user">${topologyservice.gateway.username}</parameter>
                <parameter name="password">${topologyservice.gateway.password}</parameter>
                <parameter name="disableSSLValidation">true</parameter>
                <parameter name="query">
                    PREFIX srm: &lt;http://ontologies.emc.com/2013/08/srm#&gt;
				SELECT DISTINCT ?plun ?srcarray ?srclun
				WHERE {
                ?volume a srm:StorageVolume .
                ?volume srm:displayName ?srclun .
                ?volume srm:volumeWWN ?plun .
                ?volume srm:residesOnStorageArray ?array .
                ?array a srm:StorageArray .
                ?array srm:displayName ?srcarray .
                ?array srm:model "VNXBlock"^^&lt;http://www.w3.org/2001/XMLSchema#string&gt; .
				}
                </parameter>
            </accessor>
            <field-separator>,</field-separator>
            <field-quoting>"</field-quoting>
            <default-symbol>**</default-symbol>
            <property-insertion start="[" end="]"/>
            <key-properties>
            <key-property delete-after-use="false" string-type="string">plun</key-property>
            </key-properties>
            <new-properties>
				<new-property>srcarray</new-property>
                <new-property>srclun</new-property>
            </new-properties>
        </text-file>
		[/#if]

		<!--Create 'part' by concatenating "LOGICAL UNIT NUMBER " and 'partid' when LUN is MetaHead and metric is from SAH.
		Applicable to classic vnx block only as there are no metaheads in vnxe.-->
		<text-file path="conf/set_metalun_part.csv">
			<accessor accessor-class="StaticAccessor">
				<parameter name="field-separator">,</parameter>
				<parameter name="field-quoting">"</parameter>
				<parameter name="line">VNXBlock-Collector,VNX-SAF,LUN,1,[part][partid]</parameter>
			</accessor>
			<field-separator>,</field-separator>
			<default-symbol>**</default-symbol>
			<null-symbol>@@</null-symbol>
			<property-insertion start="[" end="]" />
			<key-properties>
					<key-property delete-after-use="false" string-type="string">source</key-property>
					<key-property delete-after-use="false" string-type="string">datagrp</key-property>
					<key-property delete-after-use="false" string-type="string">parttype</key-property>
					<key-property delete-after-use="false" string-type="string">ismetah</key-property>
			</key-properties>
			<new-properties>
				<new-property>part</new-property>
			</new-properties>
		</text-file>
		<!-- Applicable to classic vnx File -->
		<text-file path="conf/luntagid.csv">
			<accessor accessor-class="StaticAccessor">
				<parameter name="field-separator">,</parameter>
				<parameter name="field-quoting">"</parameter>
				<parameter name="line">VNXFile-Collector,Disk,[storsn]_0[storlun]</parameter>
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
		<!-- Applicable to File -->
		<text-file path="conf/rename_variableidfile.csv">
			<accessor accessor-class="StaticAccessor">
				<parameter name="field-separator">,</parameter>
				<parameter name="field-quoting">"</parameter>
				<parameter name="line">File,[datagrp][serialnb][parttype][moverid][partid][ifname][volumeid][qpath][partsn][name]</parameter>
			</accessor>
			<field-separator>,</field-separator>
			<default-symbol>**</default-symbol>
			<property-insertion start="[" end="]" />
			<key-properties>
				<key-property delete-after-use="false" string-type="string">datatype</key-property>
			</key-properties>
			<new-properties>
				<new-property>RV_Variable</new-property>
			</new-properties>
		</text-file>
	</files>
</property-tagging-filter-config>
