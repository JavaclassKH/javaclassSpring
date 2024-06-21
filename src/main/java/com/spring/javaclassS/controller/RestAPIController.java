package com.spring.javaclassS.controller;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/restapi")
public class RestAPIController {

	@ResponseBody
	@RequestMapping(value = "/restapiTest2/{message}", method = RequestMethod.GET)
	public String RestapiTest2Get(@PathVariable String message) {
		System.out.println(message);
		
		
		return "message : " + message;
	}
	
	@RequestMapping(value = "/restapiTest3/{message}", method = RequestMethod.GET)
	public String RestapiTest3Get(@PathVariable String message) {
		System.out.println(message);
		
		
		return "<div><font color='red'>message : " + message + "</font></div>";
	}

	
}
