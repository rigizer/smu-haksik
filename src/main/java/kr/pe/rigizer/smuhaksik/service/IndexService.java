package kr.pe.rigizer.smuhaksik.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

@Service
public class IndexService {
	private String haksikUrl = "http://setopia.semyung.ac.kr/main/program/menu/foodProcDate.jsp?cafe_cd=%s";
	
	public Map<String, List<String>> getHaksik(String code) {
		String html = getHtml(code);
		
		return parseHtml(html);
	}

	private String getHtml(String code) {
		String url = String.format(haksikUrl, code);
		
		Document doc = null;
		String html = "";
		try {
			doc = Jsoup.connect(url).get();
			html = doc.html();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return html;
	}
	
	private Map<String, List<String>> parseHtml(String html) {
		Map<String, List<String>> haksikData = new HashMap<>();
		List<String> dateList = new ArrayList<>();
		List<String> haksikList = new ArrayList<>();
		
		Document doc = Jsoup.parse(html);
		
		Elements tableTdList = doc.select("table > tbody > tr[bgcolor=#f8f8f9] > td");
		
		for (Element t: tableTdList) {
			int i = 0;
			boolean tfCheck = true;
			
			try {
				i = Integer.parseInt(t.attr("colspan"));
			} catch (Exception e) {
				i = 0;
			} finally {
				tfCheck = i != 2 ? true : false;	// T: 식단, F: 날짜
			}
			
			String content = t
					.toString()
					.replace("<br/>", "\n");
			
			content = Jsoup.parse(content).toString();
			
			String contentText = Jsoup.parse(content).text().trim();
			
			if (tfCheck == true) {
				List<String> blackWords = new ArrayList<>();
				blackWords.add("원산지");
				blackWords.add("식자재");
				blackWords.add("이용시간");
				
				for (String blackWord: blackWords) {
					if (content.contains(blackWord)) {
						content = "(메뉴 없음)";
					} else if (contentText.isEmpty()) {
						content = "(메뉴 없음)";
					}
				}
				
				haksikList.add(content);
			} else {
				dateList.add(content);
			}
		}
		
		haksikData.put("dateList", dateList);
		haksikData.put("haksikList", haksikList);
		
		return haksikData;
	}
}
