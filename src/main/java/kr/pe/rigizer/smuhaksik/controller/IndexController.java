package kr.pe.rigizer.smuhaksik.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.pe.rigizer.smuhaksik.service.IndexService;

@Controller
public class IndexController {
	@Autowired IndexService indexService;
	
	@RequestMapping(value="/index")
	public String index(Model model, HttpServletRequest request, 
			@RequestParam(value="code", defaultValue="GH002") String code) {
		Map<String, List<String>> haksikData = indexService.getHaksik(code);
		
		List<String> dateList = haksikData.get("dateList");
		List<String> haksikList = haksikData.get("haksikList");
		
		model.addAttribute("dateList", dateList);
		model.addAttribute("haksikList", haksikList);
		model.addAttribute("code", code);
		
		return "index";
	}
}
