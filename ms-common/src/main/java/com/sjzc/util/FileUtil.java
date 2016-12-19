package com.sjzc.util;

import javax.activation.MimetypesFileTypeMap;
import java.io.*;
import java.nio.ByteBuffer;
import java.nio.channels.Channels;
import java.nio.channels.FileChannel;
import java.nio.channels.ReadableByteChannel;

/**
 * 文件工具类
 * @ClassName:  FileUtil   
 * @author: sjzc
 * @date:   2015年11月3日 下午3:16:35
 */
public final class FileUtil implements Serializable {
	private static final long serialVersionUID = 4925373245805380456L;

	public static String getExt(String name){
		return name.substring(name.lastIndexOf(".")).toLowerCase();
	}
	public static String getImageExtByContentType(String type){
		if(!isImageContentType(type))
			return null;
		String ext=type.substring(type.indexOf("/")+1).toLowerCase();
		if("jpeg".equals(ext)||"jpg".equals(ext))
			return "jpeg";
		else if("png".equals(ext))
			return "png";
		else if("gif".equals(ext))
			return "gif";
		else
			return null;
	}
	public static boolean isImage(String name){
		return isImageContentType(getContentType(name));
	}
	public static boolean isImage(File file){
		return isImageContentType(getContentType(file));
	}
	public static boolean isImageContentType(String type){
		if(null==type||"".equals(type.trim()))
			return false;
		return type.trim().toLowerCase().startsWith("image/");
	}
	public static String getContentType(File file){
		return new MimetypesFileTypeMap().getContentType(file);
	}
	public static String getContentType(String name){
		return new MimetypesFileTypeMap().getContentType(name.trim().toLowerCase());
	}
	public static boolean isAudio(String name){
		return isAudioContentType(getContentType(name));
	}
	public static boolean isAudioContentType(String type){
		if(null==type)
			return false;
		return type.trim().toLowerCase().startsWith("audio/");
	}
	public static boolean isVideo(String name){
		return isVideoContentType(getContentType(name));
	}
	public static boolean isVideoContentType(String type){
		if(null==type)
			return false;
		return type.trim().toLowerCase().startsWith("video/");
	}
	public static boolean checkName(String name){
		String[] e={
				"\\",
				"/",
				":",
				"*",
				"?",
				"\"",
				"<",
				">",
				"|",
				"\t",
				"\n",
				"\r",
				"'"
		};
		if(null==name||"".equals(name))
			return false;
		/*
		if(name.indexOf(".")<0)
			return false;
		*/
		if(".".equals(name.substring(0, 1)))
			return false;
		if(".".equals(name.substring(name.length()-2, name.length()-1)))
			return false;
		for(int i=0;i<e.length;i++){
			if(name.indexOf(e[i])>-1)
				return false;
		}
		
		return true;
	}
	public static int getSize(File file){
		FileInputStream stream=null;
		try {
			stream=new FileInputStream(file);
			return stream.available();
		} catch (IOException e) {
			return -1;
		}finally{
			try {
				if(null!=stream)
					stream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	public static String readText(File file) throws IOException {
		StringBuffer ret=new StringBuffer();
		String buf;
		
		BufferedReader handle=new BufferedReader(new FileReader(file));
		while (null!=(buf=handle.readLine())) {
			ret.append(buf);
			ret.append("\n");
		}
		handle.close();
		return ret.toString();
	}
	
	public static String readText(String path) throws IOException {
		return readText(new File(path));
	}
	
	public static void writeText(String path, String content) throws IOException {
		writeText(new File(path), content);
	}
	
	public static void writeText(File file, String content) throws IOException {
		PrintWriter handle=new PrintWriter(new BufferedWriter(new FileWriter(file)));
		handle.print(content);
		handle.close();
	}
	
	public static void appendText(String path, String content) throws IOException {
		appendText(new File(path), content);
	}
	
	public static void appendText(File file, String content) throws IOException {
		FileWriter writer=new FileWriter(file, true);
		writer.write(content);
		writer.close();
	}
	
	public static byte[] read(String path) throws IOException,Exception {
		return read(new File(path));
	}
	
	public static byte[] read(File file) throws IOException {
		if (!file.exists()||!file.isFile())
			throw new IOException();
		
		long size=file.length();
		if (size>Integer.MAX_VALUE)
			throw new IOException("file is too large");
		
		ByteBuffer ret=ByteBuffer.allocate((int)size);
		
		FileInputStream handle=new FileInputStream(file);
		FileChannel channel=handle.getChannel();
		
		ByteBuffer buf=ByteBuffer.allocate(1024);
		while (channel.read(buf)!=-1) {
			buf.flip();
			ret.put(buf);
			buf.clear();
		}
		channel.close();
		handle.close();
		
		ret.flip();
		return ret.array();
	}
	
	public static void write(File file, byte[] content) throws IOException {
		FileOutputStream handle=new FileOutputStream(file);
		FileChannel channel=handle.getChannel();
		channel.write(ByteBuffer.wrap(content));
		channel.close();
		handle.close();
	}
	
	public static void write(File file, InputStream stream) throws Exception {
		FileOutputStream out=null;
		FileChannel to=null;
		ReadableByteChannel from=null;
		
		try{
			out=new FileOutputStream(file);
			to=out.getChannel();
			from=Channels.newChannel(stream);
			to.transferFrom(from, 0, stream.available());
		}catch(Exception e){
			throw e;
		}finally{
			if(null!=to)
				try {
					to.close();
				} catch (IOException e) {
				}
			if(null!=out)
				try {
					out.close();
				} catch (IOException e) {
				}
			if(null!=from)
				try {
					from.close();
				} catch (IOException e) {
				}
		}
	}
	
	public static void write(String path, byte[] content) throws IOException {
		write(new File(path), content);
	}
	
	public static void write(File file, String content) throws IOException {
		writeText(file, content);
	}
	
	public static void write(String path, String content) throws IOException {
		writeText(path, content);
	}
	
	public static void copy(File from, File to) throws IOException {
		if (!from.exists()||!from.isFile())
			throw new IOException();
		
		FileInputStream in=new FileInputStream(from);
		FileOutputStream out=new FileOutputStream(to);
		
		FileChannel inChannel=in.getChannel();
		FileChannel outChannel=out.getChannel();
		
		int written=0;
		long total=inChannel.size();
		while (written<total) {
			written+=inChannel.transferTo(written, total-written, outChannel);
		}
		
		inChannel.close();
		outChannel.close();
		in.close();
		out.close();
	}
	
	public static void copy(String from, String to) throws IOException {
		copy(new File(from), new File(to));
	}
	
	public static void rmdir(File dir) throws IOException {
		if(null==dir||!dir.exists()||!dir.isDirectory())
			throw new IOException("Directory not exists");
		for(File file: dir.listFiles()){
			if(file.isDirectory()){
				rmdir(file);
			}else{
				file.delete();
			}
		}
		dir.delete();
	}
}
