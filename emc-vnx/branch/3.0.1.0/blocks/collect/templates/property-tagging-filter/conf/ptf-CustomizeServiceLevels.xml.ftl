[#ftl]
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
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
<property-tagging-filter-config xmlns="http://www.watch4net.com/APG/Filter/PropertyTaggingFilter">
    <refresh unit="minutes">5</refresh>
    <files>

        <text-file encoding="UTF-8" path="conf/ServiceLevel by Disk.csv">
            <field-separator>,</field-separator>
            <default-symbol>**</default-symbol>
            <null-symbol>@@</null-symbol>
            <key-properties>
                <key-property delete-after-use="false" string-type="string">parttype</key-property>
                <key-property delete-after-use="false" string-type="regex">dgraid</key-property>
                <key-property delete-after-use="false" string-type="regex">disktype</key-property>
                <key-property delete-after-use="false" string-type="regex">disksize</key-property>
                <key-property delete-after-use="false" string-type="string">isfcache</key-property>
            </key-properties>
            <new-properties>
                <new-property>svclevel</new-property>
            </new-properties>
        </text-file>

        <text-file encoding="UTF-8" path="conf/DoNotModify FASTVP SL.csv">
            <accessor accessor-class="StaticAccessor">
                <parameter name="line">LUN,Thin,1,FAST VP</parameter>
            </accessor>
            <field-separator>,</field-separator>
            <default-symbol>**</default-symbol>
            <null-symbol>@@</null-symbol>
            <key-properties>
                <key-property delete-after-use="false" string-type="string">parttype</key-property>
                <key-property delete-after-use="false" string-type="string">dgstype</key-property>
                <key-property delete-after-use="false" string-type="string">isfast</key-property>
            </key-properties>
            <new-properties>
                <new-property>svclevel</new-property>
            </new-properties>
        </text-file>

        <text-file encoding="UTF-8" path="conf/ServiceLevel by FASTVP.csv">
            <field-separator>,</field-separator>
            <default-symbol>**</default-symbol>
            <null-symbol>@@</null-symbol>
            <key-properties>
                <key-property delete-after-use="false" string-type="string">parttype</key-property>
                <key-property delete-after-use="false" string-type="string">isfast</key-property>
                <key-property delete-after-use="false" string-type="regex">poolname</key-property>
                <key-property delete-after-use="false" string-type="regex">polname</key-property>
                <key-property delete-after-use="false" string-type="string">isfcache</key-property>
            </key-properties>
            <new-properties>
                <new-property>svclevel</new-property>
            </new-properties>
        </text-file>

        <text-file encoding="UTF-8" path="conf/DoNotModify System Resource and Pool Contributor SL.csv">
            <accessor accessor-class="StaticAccessor">
                <parameter name="line">LUN,System Resource,**,System Resource</parameter>
                <parameter name="line">LUN,**,1,Pool Contributor</parameter>
            </accessor>
            <field-separator>,</field-separator>
            <default-symbol>**</default-symbol>
            <null-symbol>@@</null-symbol>
            <key-properties>
                <key-property delete-after-use="false" string-type="string">parttype</key-property>
                <key-property delete-after-use="false" string-type="string">purpose</key-property>
                <key-property delete-after-use="false" string-type="string">ispolctr</key-property>
            </key-properties>
            <new-properties>
                <new-property>svclevel</new-property>
            </new-properties>
        </text-file>

        <!-- default scvlevel to Other but NOT when dgraid and disktype is not in yet -->
        <text-file encoding="UTF-8" path="conf/DoNotModify Other SL.csv">
            <accessor accessor-class="StaticAccessor">
                <parameter name="line">Capacity,LUN,@@,Other</parameter>
            </accessor>
            <field-separator>,</field-separator>
            <default-symbol>**</default-symbol>
            <null-symbol>@@</null-symbol>
            <key-properties>
                <key-property delete-after-use="false" string-type="string">name</key-property>
                <key-property delete-after-use="false" string-type="string">parttype</key-property>
                <key-property delete-after-use="false" string-type="string">svclevel</key-property>
            </key-properties>
            <new-properties>
                <new-property>svclevel</new-property>
            </new-properties>
        </text-file>

    </files>

</property-tagging-filter-config>

