[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<config xmlns="http://www.watch4net.com/APG/Smarts/DomainDiscovery1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.watch4net.com/APG/Smarts/DomainDiscovery1 DomainDiscovery1.xsd">
	<authentication>
		<broker>${smarts.broker.host}:${smarts.broker.port}</broker>
		[#if smarts.broker.use_authentication]
		<broker-username>${smarts.broker.username}</broker-username>
		<broker-password>${smarts.broker.password}</broker-password>
		[/#if]
		<domains refresh-period="240">
			<default-username>${default.username}</default-username>
			<default-password>${default.password}</default-password>
			[#if smarts.domain?? && smarts.domain?size > 0]
			<overrides>
			[#list smarts.domain as domain]
				[#if domain.overrides??]
				<domain name="${domain.name}">
					<username>${domain.overrides.username}</username>
					<password>${domain.overrides.password}</password>
				</domain>
				[/#if]
			[/#list]
			</overrides>
			[/#if]
		</domains>
	</authentication>
	[#if smarts.domain?? && smarts.domain?size > 0]
	<domains default-exclude="true">
		[#list smarts.domain as domain]
		<include>${domain.name}</include>
		[/#list]
	</domains>
	[/#if]
	<templates>
		<template>
			<!-- AM/PM Domains -->
			<features>
				<feature>Feature-DEVSTAT</feature>
				<feature>Feature-PERFORMANCE</feature>
				<feature>ICIM_Manager::ICIM-Manager::AMPM_Mode=AVAILABILITY_AND_PERFORMANCE_MANAGER</feature>
			</features>
			<configuration>conf/smarts-pm-health.xml</configuration>
			<configuration>conf/smarts-pm.xml</configuration>
		</template>
		<template>
			<!-- PM Domains -->
			<features>
				<feature>Feature-DEVSTAT</feature>
				<feature>Feature-PERFORMANCE</feature>
				<feature>ICIM_Manager::ICIM-Manager::AMPM_Mode=PERFORMANCE_MANAGER</feature>
			</features>
			<configuration>conf/smarts-pm-health.xml</configuration>
			<configuration>conf/smarts-pm.xml</configuration>
		</template>
		<template>
			<!-- ACM Domains -->
			<features>
				<feature>Feature-AI_ACM</feature>
			</features>
			<configuration>conf/smarts-pm-health.xml</configuration>
			<configuration>conf/smarts-acm2.xml</configuration>
		</template>
		<default>
			<!-- Other Domains -->
			<configuration>conf/smarts-pm-health.xml</configuration>
		</default>
	</templates>
</config>
                