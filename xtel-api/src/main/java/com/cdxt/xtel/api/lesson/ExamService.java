package com.cdxt.xtel.api.lesson;

import java.util.List;
import java.util.Map;

import com.cdxt.xtel.core.model.PagePojo;
import com.cdxt.xtel.core.model.ResJson;
import com.cdxt.xtel.pojo.lesson.ChoiceQuestion;
import com.cdxt.xtel.pojo.lesson.EssayQuestion;
import com.cdxt.xtel.pojo.lesson.ExamArrangement;
import com.cdxt.xtel.pojo.lesson.ExamPaper;
import com.cdxt.xtel.pojo.lesson.Exercises;

public interface ExamService {

	PagePojo listExaminationPage(Integer pageNo, Integer pageSize, Map<String, Object> params);

	PagePojo getExaminationArrangementPage(int userID, Integer pageNo, Integer pageSize);

	PagePojo getUserPerformancePage(int userID, Integer pageNo, Integer pageSize);
	/**
	 * 
	 * @Title: listExerciseList
	 * @author wangxiaolong
	 * @Description:试题列表
	 * @param
	 * @return
	 */
	PagePojo  listExercise(Integer pageNo, Integer pageSize,Map<String, Object> params);

	/**
	 * 
	 * @Title: addExercise
	 * @author wangxiaolong
	 * @Description:添加试题
	 * @param
	 * @return
	 */
	ResJson addExercise(Exercises exercises,ChoiceQuestion choiceQuestion,EssayQuestion essayQuestion);

	PagePojo getExerciseList(int userID,Integer type, Integer pageNo, Integer pageSize);

	List<Map<String, Object>> listExerciseByIds(Integer[]  userId,Integer type);  

	void addExam(String   userId,ExamPaper paper);
	
	PagePojo listExamArrangeByUserId(Integer pageNo, Integer pageSize, Integer userId);
	
	/**
	 * 
	 * @Title: listExercisesByPaperId
	 * @author wangxiaolong
	 * @Description:根据试卷查询试题
	 * @param
	 * @return
	 */
	List<Map<String, Object>> listExercisesByPaperId(Integer paperId);
	
	void addExamRecord(Integer userId,Integer examId,String answers);
	
	PagePojo listExamRecord(Integer pageNo, Integer pageSize,Integer userId);
	
	/**
	 * 
	 * @Title: getUserDetailAnswers
	 * @author wangxiaolong
	 * @Description:查询考生详细答题信息
	 * @param
	 * @return
	 */
	List<Map<String, Object>> getUserDetailAnswers(Integer id);
	
	/**
	 * 
	 * @Title: getExamPaperByCourseId
	 * @author wangxiaolong
	 * @Description:根据课程查询试卷
	 * @param
	 * @return
	 */
	List<Map<String, Object>> getExamPaperByCourseId(Integer courseId);
	
	int addExamArrange(ExamArrangement examArrangement);
}

