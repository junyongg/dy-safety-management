package com.tx.common.security.aes;

import java.security.spec.AlgorithmParameterSpec;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;

/**
 * Created by 김선호 on 2018-04-26.
 */
public class AES256Cipher {

    private static byte[] ivBytes = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
    private static String secretKey = "tronix-slmcs!@!%";

    public static String encode(String str) throws Exception {

		byte[] bytes = str.getBytes("UTF-8");

		AlgorithmParameterSpec spec = new IvParameterSpec(ivBytes);
		SecretKeySpec keySpec = new SecretKeySpec(secretKey.getBytes("UTF-8"), "AES");

		Cipher cipher;
		cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		cipher.init(Cipher.ENCRYPT_MODE, keySpec, spec);

		return new String(Base64.encodeBase64(cipher.doFinal(bytes)));
	}

	public static String decode(String str) throws Exception {

		byte[] bytes = Base64.decodeBase64(str.getBytes());

		AlgorithmParameterSpec spec = new IvParameterSpec(ivBytes);
		SecretKeySpec keySpec = new SecretKeySpec(secretKey.getBytes("UTF-8"), "AES");

		Cipher cipher;
		cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		cipher.init(Cipher.DECRYPT_MODE, keySpec, spec);

		return new String(cipher.doFinal(bytes));
	}
	
}