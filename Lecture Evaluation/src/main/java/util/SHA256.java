package util;

import java.security.MessageDigest;

//회원가입이후 이메일 인증을 할때 기존 이메일에서 해시값을 적용해서 사용자가 인증코드로 링크를타고 접속하는게 일반적인데 대표적으로 사용하는방법
public class SHA256 {
	
	public static String getSHA256(String input) {
		StringBuffer result = new StringBuffer();
		try {
			MessageDigest digest  = MessageDigest.getInstance("SHA-256");
			byte[] salt = "Hello! This is Salt.".getBytes();
			digest.reset();
			digest.update(salt);
			byte[] chars = digest.digest(input.getBytes("UTF-8"));
			for(int i=0;i<chars.length;i++) {
				String hex = Integer.toHexString(0xff & chars[i]);
				if(hex.length() == 1)result.append("0");
				result.append(hex);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result.toString();
	}
}
