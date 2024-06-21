package com.spring.javaclassS.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("G yyyy-MM-dd HH:mm:ss");
		model.addAttribute("serverTime", sdf.format(date));
		model.addAttribute("NewJeans" , "How Sweet");
		
		return "home";
	}
	
}
