package javasource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.ArrayList;
import java.util.Calendar;

public class testdate {
	
	ArrayList<String> dates = new ArrayList<String>();
	
	
	public ArrayList<String> getdates(String stdt, String endt) {
		String startDt = stdt; //체크인 날짜 받기
        String endDttmp = endt; //체크아웃 날짜 받기       
        
        //체크인 날짜 끊기
        int startYear = Integer.parseInt(startDt.substring(0,4));
        int startMonth= Integer.parseInt(startDt.substring(5,7));
        int startDate = Integer.parseInt(startDt.substring(8,10));
        
        //체크아웃 날짜 integer로 변환
        endDttmp = endDttmp.replaceAll("-", "");
        int endDt = Integer.parseInt(endDttmp);
 
        Calendar cal = Calendar.getInstance();
         
        // Calendar의 Month는 0부터 시작하므로 -1
        // Calendar의 기본 날짜를 startDt로 셋팅
        cal.set(startYear, startMonth -1, startDate);   
         
        while(true) {
            // 날짜 배열에 넣기
        	String tmp;
        	tmp = getDateByString(cal.getTime());
        	dates.add(tmp);  
            // Calendar의 날짜를 하루씩 증가
            cal.add(Calendar.DATE, 1); // one day increment
             
            // 현재 날짜가 종료일자보다 크면 종료 
            if(getDateByInteger(cal.getTime()) >= endDt) break;            
        }
        System.out.println(dates);
        return dates;
    }
     
    public static int getDateByInteger(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        return Integer.parseInt(sdf.format(date));
    }
     
    public static String getDateByString(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(date);

	}
}