package com.cdxt.xtel.server.impl.lesson;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.dubbo.config.annotation.Service;
import com.cdxt.xtel.api.lesson.ExamService;
import com.cdxt.xtel.core.constant.SysConstants;
import com.cdxt.xtel.core.model.PagePojo;
import com.cdxt.xtel.core.model.ResJson;
import com.cdxt.xtel.core.util.DateUtils;
import com.cdxt.xtel.core.util.PageUtil;
import com.cdxt.xtel.core.util.oConvertUtils;
import com.cdxt.xtel.pojo.lesson.Answers;
import com.cdxt.xtel.pojo.lesson.ChoiceQuestion;
import com.cdxt.xtel.pojo.lesson.EssayQuestion;
import com.cdxt.xtel.pojo.lesson.ExamArrangement;
import com.cdxt.xtel.pojo.lesson.ExamPaper;
import com.cdxt.xtel.pojo.lesson.ExamRecord;
import com.cdxt.xtel.pojo.lesson.Exer2ExamPaper;
import com.cdxt.xtel.pojo.lesson.Exercises;
import com.cdxt.xtel.server.mapper.lesson.ExamDao;
import com.github.pagehelper.PageHelper;


@Service
@Component
@Transactional
public class ExamServiceImpl implements ExamService {

	@Autowired
	private  ExamDao  examDao;

	public PagePojo  listExercise (Integer pageNo, Integer pageSize,Map<String, Object> params){

		PageHelper.startPage(pageNo, pageSize);
		List<Map<String, Object>> mapList= examDao.listExercise(params);
		return PageUtil.Map2PageInfo(mapList);

	}
	@Override
	public PagePojo listExaminationPage(Integer pageNo, Integer pageSize,Map<String, Object> params){

		PageHelper.startPage(pageNo, pageSize);
		List<Map<String, Object>> mapList= examDao.listExaminationPage(params);
		return PageUtil.Map2PageInfo(mapList);
	}

	@Override
	public PagePojo getExaminationArrangementPage(int userID, Integer pageNo, Integer pageSize) {
		PageHelper.startPage(pageNo, pageSize);
		List<Map<String, Object>> mapList=  examDao.getExaminationArrangementPage(userID);
		return PageUtil.Map2PageInfo(mapList);
	}

	@Override
	public PagePojo getUserPerformancePage(int userID, Integer pageNo, Integer pageSize){

		List<Map<String, Object>> mapList=  examDao.getUserPerformancePage(userID);

		return PageUtil.Map2PageInfo(mapList);
	}

	public ResJson addExercise(Exercises exercises,ChoiceQuestion choiceQuestion,EssayQuestion essayQuestion){
		int results=0;

		Integer type=exercises.getType();
		Integer id=0;
		if(oConvertUtils.isNotEmpty(type)){
			switch(type){
			//选择题
			case 0:
				id=examDao.insertChoiceQuestion(choiceQuestion);
				id=choiceQuestion.getId();
				break;
			case 1:	
				id=examDao.insertEssayQuestion(essayQuestion);
				id=essayQuestion.getId();
				break;	
			default :
				break;
			}
			//判断前面是否成功插入了
			if(id!=0){
				exercises.setRecordId(id);

				exercises.setUploadTime(new Date().getTime());
				results=examDao.InsertExercises(exercises);
			}
		}
		if(results==1){
			return new ResJson(SysConstants.STRING_ONE,"保存成功");
		}

		return new ResJson(SysConstants.STRING_ZERO,"保存失败");
	}
	@Override
	public PagePojo getExerciseList(int userID,Integer type, Integer pageNo, Integer pageSize) {
		PageHelper.startPage(pageNo, pageSize);
		List<Map<String, Object>> mapList;
		//0–选择题  1–问答题    2–填空题
		if(type==0){
			mapList=examDao.getChoiceQuestion(userID,null);
		}else if(type==1){
			mapList=examDao.getEssayQuestion(userID,null);
		}else{
			mapList=examDao.getFillUpQuestion(userID,null);
		}
		return PageUtil.Map2PageInfo(mapList);
	}

	@Override
	public List<Map<String, Object>> listExerciseByIds(Integer[] ids,Integer type){
		List<Map<String, Object>> mapList;
		if(type==0){
			mapList=  examDao.getChoiceQuestion(null,ids);
		}else if(type==1){
			mapList= examDao.getEssayQuestion(null,ids);
		}else{
			mapList=examDao.getFillUpQuestion(null,ids);
		}
		return mapList;
	}

	public void addExam(String   exerIds,ExamPaper paper){
		paper.setUploadTime(DateUtils.getMillis());
		Integer id=examDao.insertExamPaper(paper);
		List<Exer2ExamPaper>list=new ArrayList<Exer2ExamPaper>();
		String[] exerIdArray=exerIds.split(",");
		if(id!=null){
			for(String exerId:exerIdArray){
				String []id2Score=exerId.split("@");
	
				Exer2ExamPaper exer2ExamPaper=new Exer2ExamPaper();
				exer2ExamPaper.setScore(Integer.parseInt(id2Score[0]));
				exer2ExamPaper.setExerId(Integer.parseInt(id2Score[1]));
				exer2ExamPaper.setPaperId(paper.getId());
				list.add(exer2ExamPaper);
			}
		}
		examDao.batchInsertExer2ExamPaper(list);

	}
	/**
	 * 
	 * @Title: listExamArrange
	 * @Description:查询考试安排，学生
	 * @param
	 * @return
	 */
	public PagePojo listExamArrangeByUserId(Integer pageNo, Integer pageSize, Integer userId){
		PageHelper.startPage(pageNo, pageSize);
		List<Map<String, Object>> mapList= examDao.listExamArrangeByUserId(userId);
		return PageUtil.Map2PageInfo(mapList);
	}

	/**
	 * 
	 * @Title: listExamArrangeByUserId
	 * @Description:根据试卷id查询试题
	 * @param
	 * @return
	 */
	public List<Map<String, Object>> listExercisesByPaperId(Integer paperId){

		return examDao.listExercisesByPaperId(paperId);
	}

	/**
	 * 
	 * @Title: addExamRecord
	 * @Description:
	 * @param
	 * @return
	 */
	public void addExamRecord(Integer userId,Integer examId,String answers){
		ExamRecord examRecord=new ExamRecord();
		examRecord.setExamId(examId);
		examRecord.setTime(DateUtils.getMillis());
		examRecord.setUserId(userId);
		Integer id=examDao.insertExamRecord(examRecord);
		List<Answers>answersList=new ArrayList<Answers>();
		if(id!=null){
			String[] answersArray=answers.split(",");
			Answers answer=null;
			for(String arrays:answersArray){
				String[] arr=arrays.split("@");
				if(arr!=null&&arr.length>1){
					answer=new Answers();
					answer.setExerId(Integer.parseInt(arr[0].toString()));
					answer.setPuepId(examRecord.getId());
					answer.setUserId(userId);
					answer.setAnswer(arr[1]);
					answersList.add(answer);
				}
			}
			examDao.batchInsertAnswers(answersList);
		}
	}
	
	@Override
	public PagePojo listExamRecord(Integer pageNo, Integer pageSize,Integer userId){

		PageHelper.startPage(pageNo, pageSize);
		List<Map<String, Object>> mapList= examDao.listExamRecord(userId);
		return PageUtil.Map2PageInfo(mapList);
	}
	
	public List<Map<String, Object>> getUserDetailAnswers(Integer id){
		return examDao.getUserDetailAnswers(id);
	}
	
	public List<Map<String, Object>> getExamPaperByCourseId(Integer courseId){
		return examDao.getExamPaperByCourseId(courseId);
	}
	
	public  int addExamArrange(ExamArrangement examArrangement){
		
		return examDao.addExamArrange(examArrangement);
	}
}
