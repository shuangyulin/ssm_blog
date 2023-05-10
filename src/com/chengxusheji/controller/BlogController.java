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
import com.chengxusheji.service.BlogService;
import com.chengxusheji.po.Blog;
import com.chengxusheji.service.BlogClassService;
import com.chengxusheji.po.BlogClass;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//Blog管理控制层
@Controller
@RequestMapping("/Blog")
public class BlogController extends BaseController {

    /*业务层对象*/
    @Resource BlogService blogService;

    @Resource BlogClassService blogClassService;
    @Resource UserInfoService userInfoService;
	@InitBinder("blogClassObj")
	public void initBinderblogClassObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("blogClassObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("blog")
	public void initBinderBlog(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("blog.");
	}
	/*跳转到添加Blog视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Blog());
		/*查询所有的BlogClass信息*/
		List<BlogClass> blogClassList = blogClassService.queryAllBlogClass();
		request.setAttribute("blogClassList", blogClassList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "Blog_add";
	}

	/*客户端ajax方式提交添加博客信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Blog blog, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			blog.setBlogPhoto(this.handlePhotoUpload(request, "blogPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        blogService.addBlog(blog);
        message = "博客添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询博客信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("blogClassObj") BlogClass blogClassObj,String title,@ModelAttribute("userObj") UserInfo userObj,String addTime,String shzt,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (title == null) title = "";
		if (addTime == null) addTime = "";
		if (shzt == null) shzt = "";
		if(rows != 0)blogService.setRows(rows);
		List<Blog> blogList = blogService.queryBlog(blogClassObj, title, userObj, addTime, shzt, page);
	    /*计算总的页数和总的记录数*/
	    blogService.queryTotalPageAndRecordNumber(blogClassObj, title, userObj, addTime, shzt);
	    /*获取到总的页码数目*/
	    int totalPage = blogService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = blogService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Blog blog:blogList) {
			JSONObject jsonBlog = blog.getJsonObject();
			jsonArray.put(jsonBlog);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询博客信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Blog> blogList = blogService.queryAllBlog();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Blog blog:blogList) {
			JSONObject jsonBlog = new JSONObject();
			jsonBlog.accumulate("blogId", blog.getBlogId());
			jsonBlog.accumulate("title", blog.getTitle());
			jsonArray.put(jsonBlog);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询博客信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("blogClassObj") BlogClass blogClassObj,String title,@ModelAttribute("userObj") UserInfo userObj,String addTime,String shzt,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (title == null) title = "";
		if (addTime == null) addTime = "";
		if (shzt == null) shzt = "";
		List<Blog> blogList = blogService.queryBlog(blogClassObj, title, userObj, addTime, shzt, currentPage);
	    /*计算总的页数和总的记录数*/
	    blogService.queryTotalPageAndRecordNumber(blogClassObj, title, userObj, addTime, shzt);
	    /*获取到总的页码数目*/
	    int totalPage = blogService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = blogService.getRecordNumber();
	    request.setAttribute("blogList",  blogList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("blogClassObj", blogClassObj);
	    request.setAttribute("title", title);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("addTime", addTime);
	    request.setAttribute("shzt", shzt);
	    List<BlogClass> blogClassList = blogClassService.queryAllBlogClass();
	    request.setAttribute("blogClassList", blogClassList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Blog/blog_frontquery_result"; 
	}

     /*前台查询Blog信息*/
	@RequestMapping(value="/{blogId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer blogId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键blogId获取Blog对象*/
        Blog blog = blogService.getBlog(blogId);

        List<BlogClass> blogClassList = blogClassService.queryAllBlogClass();
        request.setAttribute("blogClassList", blogClassList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("blog",  blog);
        return "Blog/blog_frontshow";
	}

	/*ajax方式显示博客修改jsp视图页*/
	@RequestMapping(value="/{blogId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer blogId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键blogId获取Blog对象*/
        Blog blog = blogService.getBlog(blogId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonBlog = blog.getJsonObject();
		out.println(jsonBlog.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新博客信息*/
	@RequestMapping(value = "/{blogId}/update", method = RequestMethod.POST)
	public void update(@Validated Blog blog, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String blogPhotoFileName = this.handlePhotoUpload(request, "blogPhotoFile");
		if(!blogPhotoFileName.equals("upload/NoImage.jpg"))blog.setBlogPhoto(blogPhotoFileName); 


		try {
			blogService.updateBlog(blog);
			message = "博客更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "博客更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除博客信息*/
	@RequestMapping(value="/{blogId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer blogId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  blogService.deleteBlog(blogId);
	            request.setAttribute("message", "博客删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "博客删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条博客记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String blogIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = blogService.deleteBlogs(blogIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出博客信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("blogClassObj") BlogClass blogClassObj,String title,@ModelAttribute("userObj") UserInfo userObj,String addTime,String shzt, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(title == null) title = "";
        if(addTime == null) addTime = "";
        if(shzt == null) shzt = "";
        List<Blog> blogList = blogService.queryBlog(blogClassObj,title,userObj,addTime,shzt);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Blog信息记录"; 
        String[] headers = { "博客id","博客分类","博客标题","博客图片","浏览量","发布用户","发布时间","审核状态"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<blogList.size();i++) {
        	Blog blog = blogList.get(i); 
        	dataset.add(new String[]{blog.getBlogId() + "",blog.getBlogClassObj().getBlogClassName(),blog.getTitle(),blog.getBlogPhoto(),blog.getHitNum() + "",blog.getUserObj().getName(),blog.getAddTime(),blog.getShzt()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Blog.xls");//filename是下载的xls的名，建议最好用英文 
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
