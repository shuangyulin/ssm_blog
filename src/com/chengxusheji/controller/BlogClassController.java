package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.BlogClassService;
import com.chengxusheji.po.BlogClass;

//BlogClass管理控制层
@Controller
@RequestMapping("/BlogClass")
public class BlogClassController extends BaseController {

    /*业务层对象*/
    @Resource BlogClassService blogClassService;

	@InitBinder("blogClass")
	public void initBinderBlogClass(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("blogClass.");
	}
	/*跳转到添加BlogClass视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new BlogClass());
		return "BlogClass_add";
	}

	/*客户端ajax方式提交添加博客分类信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated BlogClass blogClass, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        blogClassService.addBlogClass(blogClass);
        message = "博客分类添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询博客分类信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)blogClassService.setRows(rows);
		List<BlogClass> blogClassList = blogClassService.queryBlogClass(page);
	    /*计算总的页数和总的记录数*/
	    blogClassService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = blogClassService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = blogClassService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(BlogClass blogClass:blogClassList) {
			JSONObject jsonBlogClass = blogClass.getJsonObject();
			jsonArray.put(jsonBlogClass);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询博客分类信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<BlogClass> blogClassList = blogClassService.queryAllBlogClass();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(BlogClass blogClass:blogClassList) {
			JSONObject jsonBlogClass = new JSONObject();
			jsonBlogClass.accumulate("blogClassId", blogClass.getBlogClassId());
			jsonBlogClass.accumulate("blogClassName", blogClass.getBlogClassName());
			jsonArray.put(jsonBlogClass);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询博客分类信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<BlogClass> blogClassList = blogClassService.queryBlogClass(currentPage);
	    /*计算总的页数和总的记录数*/
	    blogClassService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = blogClassService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = blogClassService.getRecordNumber();
	    request.setAttribute("blogClassList",  blogClassList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
		return "BlogClass/blogClass_frontquery_result"; 
	}

     /*前台查询BlogClass信息*/
	@RequestMapping(value="/{blogClassId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer blogClassId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键blogClassId获取BlogClass对象*/
        BlogClass blogClass = blogClassService.getBlogClass(blogClassId);

        request.setAttribute("blogClass",  blogClass);
        return "BlogClass/blogClass_frontshow";
	}

	/*ajax方式显示博客分类修改jsp视图页*/
	@RequestMapping(value="/{blogClassId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer blogClassId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键blogClassId获取BlogClass对象*/
        BlogClass blogClass = blogClassService.getBlogClass(blogClassId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonBlogClass = blogClass.getJsonObject();
		out.println(jsonBlogClass.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新博客分类信息*/
	@RequestMapping(value = "/{blogClassId}/update", method = RequestMethod.POST)
	public void update(@Validated BlogClass blogClass, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			blogClassService.updateBlogClass(blogClass);
			message = "博客分类更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "博客分类更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除博客分类信息*/
	@RequestMapping(value="/{blogClassId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer blogClassId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  blogClassService.deleteBlogClass(blogClassId);
	            request.setAttribute("message", "博客分类删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "博客分类删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条博客分类记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String blogClassIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = blogClassService.deleteBlogClasss(blogClassIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出博客分类信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel( Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<BlogClass> blogClassList = blogClassService.queryBlogClass();
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "BlogClass信息记录"; 
        String[] headers = { "博客分类id","博客分类名称","博客分类介绍"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<blogClassList.size();i++) {
        	BlogClass blogClass = blogClassList.get(i); 
        	dataset.add(new String[]{blogClass.getBlogClassId() + "",blogClass.getBlogClassName(),blogClass.getBlogClassDesc()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"BlogClass.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
