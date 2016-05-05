[#ftl]
<?xml version="1.0" encoding="UTF-8"?>
<processing-manager xmlns="http://www.watch4net.com/Events/DefaultProcessingManager" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.watch4net.com/Events/DefaultProcessingManager DefaultProcessingManager.xsd ">
	<processing-element name="NASUsers-Event" config="Generic-Live-Writer/${module['generic-live-writer'].instance}/conf/GLW-NASUsers-Event.xml" />
	<processing-element name="NASUsers-TS2Event" config="Generic-Event-Listener/${module['generic-event-listener'].instance}/conf/GEL-NASUsers-TS2Event.xml" nasdata="NASUsers-Event[data]" />
</processing-manager>