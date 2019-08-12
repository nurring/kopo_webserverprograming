package javasource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.ArrayList;
import java.util.Calendar;

public class testdate {
	
	ArrayList<String> dates = new ArrayList<String>();
	
	
	public ArrayList<String> getdates(String stdt, String endt) {
		String startDt = stdt; //üũ�� ��¥ �ޱ�
        String endDttmp = endt; //üũ�ƿ� ��¥ �ޱ�       
        
        //üũ�� ��¥ ����
        int startYear = Integer.parseInt(startDt.substring(0,4));
        int startMonth= Integer.parseInt(startDt.substring(5,7));
        int startDate = Integer.parseInt(startDt.substring(8,10));
        
        //üũ�ƿ� ��¥ integer�� ��ȯ
        endDttmp = endDttmp.replaceAll("-", "");
        int endDt = Integer.parseInt(endDttmp);
 
        Calendar cal = Calendar.getInstance();
         
        // Calendar�� Month�� 0���� �����ϹǷ� -1
        // Calendar�� �⺻ ��¥�� startDt�� ����
        cal.set(startYear, startMonth -1, startDate);   
         
        while(true) {
            // ��¥ �迭�� �ֱ�
        	String tmp;
        	tmp = getDateByString(cal.getTime());
        	dates.add(tmp);  
            // Calendar�� ��¥�� �Ϸ羿 ����
            cal.add(Calendar.DATE, 1); // one day increment
             
            // ���� ��¥�� �������ں��� ũ�� ���� 
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