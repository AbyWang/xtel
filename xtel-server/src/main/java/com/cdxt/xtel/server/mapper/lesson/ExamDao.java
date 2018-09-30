package com.cdxt.xtel.server.mapper.lesson;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.cdxt.xtel.pojo.lesson.Answers;
import com.cdxt.xtel.pojo.lesson.ChoiceQuestion;
import com.cdxt.xtel.pojo.lesson.EssayQuestion;
import com.cdxt.xtel.pojo.lesson.ExamArrangement;
import com.cdxt.xtel.pojo.lesson.ExamPaper;
import com.cdxt.xtel.pojo.lesson.ExamRecord;
import com.cdxt.xtel.pojo.lesson.Exer2ExamPaper;
import com.cdxt.xtel.pojo.lesson.Exercises;

public interface ExamDao {

	List<Map<String, Object>> listExercise(Map<String, Object> params);
	
	
	List<Map<String, Object>> listExaminationPage(Map<String, Object> params);
	
	
	List<Map<String, Object>> getExaminationArrangementPage(Integer userID);

	
	List<Map<String, Object>> getUserPerformancePage(Integer userID);
	
	/**
	 * 
	 * @Title: insertChoiceQuestion
	 * @author wangxiaolong
	 * @Description:插入选择题
	 * @param
	 * @return
	 */
	int insertChoiceQuestion(ChoiceQuestion choiceQuestion);
	
	/**
	 * 
	 * @Title: isertEssayQuestion
	 * @author wangxiaolong
	 * @Description:插入问答题
	 * @param
	 * @return
	 */
	int insertEssayQuestion(EssayQuestion essayQuestion);
	
	
	int InsertExercises(Exercises exercises);


	List<Map<String, Object>> getChoiceQuestion(@Param("userID")Integer userID,@Param("ids")Integer[]ids);


	List<Map<String, Object>> getEssayQuestion(@Param("userID")Integer userID,@Param("ids")Integer[]ids);


	List<Map<String, Object>> getFillUpQuestion(@Param("userID")Integer userID,@Param("ids")Integer[]ids);
	
	int insertExamPaper(ExamPaper examPaper);
	
	void batchInsertExer2ExamPaper(List<Exer2ExamPaper>list);
	
	List<Map<String, Object>> listExaminationPage(Integer userId);
	
	/**
	 * 
	 * @Title: listExamArrange
	 * @author wangxiaolong
	 * @Description:根据id查询考试安排
	 * @param
	 * @return
	 */
	List<Map<String, Object>> listExamArrangeByUserId(Integer userId);
	
	/**
	 * 
	 * @Title: listExamArrangeByUserId
	 * @Description:根据试卷id查询试题
	 * @param
	 * @return
	 */
	List<Map<String, Object>> listExercisesByPaperId(Integer paperId);
	
	/**
	 * 
	 * @Title: insertExamRecord
	 * @author wangxiaolong
	 * @Description:新增用户答卷记录表
	 * @param
	 * @return
	 */
	int insertExamRecord(ExamRecord examRecord);
	
	/**
	 * 
	 * @Title: batchInsertAnswers
	 * @author wangxiaolong
	 * @Description:批量插入用户答题表
	 * @param
	 * @return
	 */
	void batchInsertAnswers(List<Answers>answersList);
	
	/**
	 * 
	 * @Title: listExamRecord
	 * @author wangxiaolong
	 * @Description:查询学生试卷列表
	 * @param
	 * @return
	 */
	List<Map<String, Object>> listExamRecord(Integer userId);
	
	/**
	 * 
	 * @Title: getUserDetailAnswers
	 * @author wangxiaolong
	 * @Description:查询考生详细答题信息
	 * @param
	 * @return
	 */
	List<Map<String, Object>> getUserDetailAnswers(Integer id);
	
	List<Map<String, Object>> getExamPaperByCourseId(Integer id);
	
	int  addExamArrange(ExamArrangement examArrangement);
}
