<!--- 
 *
 * Copyright (c) 2015, Lucee Assosication Switzerland. All rights reserved.*
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either 
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public 
 * License along with this library.  If not, see <http://www.gnu.org/licenses/>.
 * 
 ---><cfscript>
component extends="org.lucee.cfml.test.LuceeTestCase"	{

	//public function setUp(){}

	public void function test(){
		createMemcachedCache();
		setting showdebugoutput="no" requesttimeout="1000";
		http result="local.result" url="#createURL("Issue0001/set.cfm")#" addtoken="true";
		dump(createURL("Issue0001/set.cfm"));
		assertEquals(true,isDate(result.filecontent.trim()));
		http result="local.result" url="#createURL("Issue0001/get.cfm")#" addtoken="true";
		sleep(10000);
		http method="get" result="local.result" url="#createURL("Issue0001/get.cfm")#" addtoken="true";
		assertEquals(false,isDate(result.filecontent.trim()));
		
		deleteCache();
		/*
		assertEquals("",result.filecontent);
		
		try{
			// error
			fail("");
		}
		catch(local.exp){}*/
	}
	
	private string function createURL(string calledName){
		var baseURL="http://#cgi.HTTP_HOST##getDirectoryFromPath(contractPath(getCurrenttemplatepath()))#";
		return baseURL&""&calledName;
	}

	private function createMemcachedCache() {
		admin 
				action="updateCacheConnection"
				type="web"
				password="#request.webadminpassword#"
				
				default="object"
				name="memcachedTest" 
				class="#request.cache.memcached.class#" 
				storage="true"
				custom="#request.cache.memcached.custom#";
	}
				
	private function deleteCache(){
		admin 
			action="removeCacheConnection"
			type="web"
			password="#request.webadminpassword#"
			name="memcachedTest";
						
	}
	
} 
</cfscript>