[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<property-tagging-filter-config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://www.watch4net.com/APG/Filter/PropertyTaggingFilter" xsi:schemaLocation="http://www.watch4net.com/APG/Filter/PropertyTaggingFilter  property-tagging-filter-config.xsd">
	<refresh unit="minutes">15</refresh>
	<files>
		<text-file path="conf/rename_variableid.csv">
			<accessor accessor-class="StaticAccessor">
				<parameter name="field-separator">,</parameter>
				<parameter name="field-quoting">"</parameter>
				<parameter name="line">[datagrp][serialnb][parttype][part][partid][memberof][portid][partsn][dgraid][dgname][name]</parameter>
			</accessor>
			<field-separator>,</field-separator>
			<default-symbol>**</default-symbol>
			<property-insertion start="[" end="]" />
			<key-properties>
			</key-properties>
			<new-properties>
				<new-property>RV_Variable</new-property>      
			</new-properties>
		</text-file>
		<text-file path="conf/set-uid.csv">
			<accessor accessor-class="StaticAccessor">
				<parameter name="field-separator">,</parameter>
				<parameter name="field-quoting">"</parameter>
				<parameter name="line">[partsn]</parameter>
			</accessor>
			<field-separator>,</field-separator>
			<default-symbol>**</default-symbol>
			<property-insertion start="[" end="]" />
			<key-properties>
			</key-properties>
			<new-properties>
				<new-property>uid</new-property>
			</new-properties>
		</text-file>
		<text-file path="conf/vnx_models.csv">
			<field-separator>,</field-separator>
			<default-symbol>**</default-symbol>
			<key-properties>
				<key-property delete-after-use="false" string-type="regex">model</key-property>
			</key-properties>
			<new-properties>
				<new-property>maxdisk</new-property>
				<new-property>maxhost</new-property>
			</new-properties>
		</text-file>
		<text-file path="conf/hd_rpm.csv">
			<field-separator>,</field-separator>
			<default-symbol>**</default-symbol>
			<key-properties>
				<key-property delete-after-use="false" string-type="regex">partmdl</key-property>
			</key-properties>
			<new-properties>
				<new-property>diskrpm</new-property>
			</new-properties>
		</text-file>
		<text-file path="conf/hd_factors.csv">
			<field-separator>,</field-separator>
			<default-symbol>**</default-symbol>
			<key-properties>
				<key-property delete-after-use="false" string-type="string">diskrpm</key-property>
				<key-property delete-after-use="false" string-type="string">disktype</key-property>
			</key-properties>
			<new-properties>
				<new-property>partmax</new-property>
				<new-property>seektime</new-property>
			</new-properties>
		</text-file>
		<text-file path="conf/disk_cost_per_gigabyte.csv">
			<field-separator>,</field-separator>
			<default-symbol>**</default-symbol>
			<key-properties>
				<key-property delete-after-use="false" string-type="regex">model</key-property>
				<key-property delete-after-use="false" string-type="string">dgraid</key-property>
				<key-property delete-after-use="false" string-type="string">tiername</key-property>
			</key-properties>
			<new-properties>
				<new-property>cost</new-property>
			</new-properties>
		</text-file>
		<text-file path="conf/business_unit.csv">
			<field-separator>,</field-separator>
			<field-quoting>"</field-quoting>
			<default-symbol>**</default-symbol>
			<null-symbol>@@</null-symbol>
			<key-properties>
				<key-property delete-after-use="false" string-type="string">device</key-property>
				<key-property delete-after-use="false" string-type="regex">part</key-property>
			</key-properties>
			<new-properties>
				<new-property>bunit</new-property>
				<new-property>appname</new-property>
				<new-property>appowner</new-property>
			</new-properties>
		</text-file>
		<text-file path="conf/moduletotier.csv">
			<field-separator>,</field-separator>
			<default-symbol>**</default-symbol>
			<key-properties>
				<key-property delete-after-use="false" string-type="string">module</key-property>
			</key-properties>
			<new-properties>
				<new-property>tiername</new-property>
			</new-properties>
		</text-file>
		[#if use_topo]
		<!-- Tag LUN Purpose based on Topology Service replica chain -->
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
	</files>
</property-tagging-filter-config>
