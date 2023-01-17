use bt_sql;
-- Q1. Cho biết họ tên và mức lương của các giáo viên nữ
select hoten, luong from giaovien;
-- Q2. Cho biết họ tên của các giáo viên và lương của họ sau khi tăng 10%.
select hoten, luong, luong*1.1 as tangluong from giaovien;
-- Q3. Cho biết mã của các giáo viên có họ tên bắt đầu là “Nguyễn” và lương trên $2000 hoặc, giáo viên là trưởng bộ môn nhận chức sau năm 1995.
select magv, hoten, luong from giaovien where (hoten like 'Nguyễn%' and  luong > 2000) or magv in (select truongbm from bomon where year(ngaynhanchuc)>'1995');
-- Q4. Cho biết tên những giáo viên khoa Công nghệ thông tin.
select hoten from giaovien where mabm in (select mabm from bomon where makhoa = 'CNTT');
-- Q5. Cho biết thông tin của bộ môn cùng thông tin giảng viên làm trưởng bộ môn đó.
select * from giaovien inner join bomon on giaovien.magv = bomon.truongbm;
-- Q6. Với mỗi giáo viên, hãy cho biết thông tin của bộ môn mà họ đang làm việc.
 select gv.magv, gv.hoten, bm.tenbm, bm.phong, bm.dienthoai, bm.truongbm, bm.makhoa from bomon bm join giaovien gv on gv.MABM = bm.MABM;
 -- Q7. Cho biết tên đề tài và giáo viên chủ nhiệm đề tài.
 select gv.magv,gv.hoten, dt.tendt from giaovien gv inner join detai dt on gv.magv = dt.GVCNDT;
 -- Q8. Với mỗi khoa cho biết thông tin trưởng khoa.
 select * from giaovien inner join khoa on khoa.TRUONGKHOA = giaovien.magv;
 -- Q9. Cho biết các giáo viên của bộ môn “Vi sinh” có tham gia đề tài 006.
select distinct gv.MAGV, gv.hoten as 'Giáo viên tham gia đề tài' 
from giaovien gv inner join thamgiadt tgdt on gv.magv = tgdt.magv where (tgdt.MADT = 006 and gv.MABM = 'vs');
-- Q10. Với những đề tài thuộc cấp quản lý “Thành phố”, cho biết mã đề tài, đề tài thuộc về chủ đề nào, họ tên
-- người chủ nghiệm đề tài cùng với ngày sinh và địa chỉ của người ấy.
select distinct dt.madt, cd.tencd, gv.hoten, gv.ngsinh as 'Ngày sinh', gv.diachi 
from giaovien gv 
inner join detai dt on gv.MAGV = dt.GVCNDT
inner join chude cd on cd.macd = dt.macd  where dt.CAPQL = 'Trường';
-- Q11. Tìm họ tên của từng giáo viên và người phụ trách chuyên môn trực tiếp của giáo viên đó.
select gv.MAGV,gv.hoten as 'Giáo viên', ptcm.hoten as 'Họ tên GVQLCM' 
from giaovien gv left join giaovien ptcm  on  gv.GVQLCM = ptcm.MAGV;
-- Q12. Tìm họ tên của những giáo viên được “Nguyễn An Trung” phụ trách trực tiếp.
select gv.magv, gv.hoten 
from giaovien gv 
where gv.gvqlcm = (select qlcm.magv from giaovien qlcm where qlcm.hoten = 'Nguyễn An Trung');
-- Q13. Cho biết tên giáo viên là trưởng bộ môn Hệ thống thông tin.
select gv.magv as 'Ma GV', gv.hoten as 'Ho ten truong BM' 
from giaovien gv
where gv.magv = (select truongbm from bomon where tenbm ='he thong thong tin');
-- Q14. Cho biết tên người chủ nhiệm đề tài của những đề tài thuộc chủ đề Quản lý giáo dục.
select gv.magv, gv.hoten as 'Ho ten chu nhiem de tai', dt.tendt as 'Ten de tai' 
from giaovien gv 
inner join detai dt on gv.magv =  dt.gvcndt
inner join chude cd on dt.macd = cd.macd where cd.tencd = 'quan ly giao duc';
-- Q15. Cho biết tên các công việc của đề tài HTTT 
-- quản lý các trường ĐH có thời gian bắt đầu trong tháng 3/2008.
select cv.tencv from congviec cv 
inner join detai dt on cv.madt = dt.madt
where dt.tendt = 'HTTT quản lý các trường ĐH' 
and month(cv.ngaybd) = 03 and year(cv.ngaybd) = 2008;
-- Q16. Cho biết tên giáo viên và tên người quản lý chuyên môn của giáo viên đó.
select gv.magv, gv.hoten as 'Ho ten giao vien', qlcm.hoten as 'Ho ten QLCM' 
from giaovien gv, giaovien qlcm where gv.gvqlcm = qlcm.magv
order by gv.magv ASC;
-- Q17. Cho biết các công việc bắt đầu trong khoảng từ 01/01/2007 đến 01/08/2007.
select sott, tencv from congviec where ngaybd between '2007/01/01' and '2007/08/01';
-- Q18. Cho biết họ tên các giáo viên cùng bộ môn với giáo viên “Trần Trà Hương”.
select distinct gv.hoten from giaovien gv, giaovien trantrahuong 
where trantrahuong.mabm = gv.mabm and trantrahuong.hoten = 'Trần Trà Hương' and not gv.hoten = 'Trần Trà Hương';
-- Q19. Tìm những giáo viên vừa là trưởng bộ môn vừa chủ nhiệm đề tài.
select distinct gv.magv, gv.hoten from giaovien gv 
inner join bomon bm on gv.magv = bm.truongbm 
inner join detai dt on bm.truongbm = dt.gvcndt;
-- Q20. Cho biết tên những giáo viên vừa là trưởng khoa và vừa là trưởng bộ môn.
select gv.magv, gv.hoten from giaovien gv inner join khoa k on gv.magv = k.truongkhoa
inner join bomon bm on k.truongkhoa = bm.truongbm;
-- Q21. Cho biết tên những trưởng bộ môn mà vừa chủ nhiệm đề tài
-- Q22. Cho biết mã số các trưởng khoa có chủ nhiệm đề tài.
-- Q23. Cho biết mã số các giáo viên thuộc bộ môn HTTT hoặc có tham gia đề tài mã 001.
select distinct gv.magv, gv.hoten from giaovien gv left join bomon bm on gv.mabm = bm.mabm
right join detai dt on gv.magv = dt.gvcndt where bm.mabm = 'HTTT' or dt.madt = 001;
-- Q24. Cho biết giáo viên làm việc cùng khoa với giáo viên 002.
select gv.magv, gv.hoten from giaovien gv 
left join bomon bm on gv.mabm = bm.mabm
inner join khoa k on k.makhoa = bm.makhoa where gv.magv = 002;
-- Q25. Tìm những giáo viên là trưởng bộ môn.
-- Q26. Cho biết họ tên và mức lương của các giáo viên.
-- Q27. Cho biết số lượng giáo viên viên và tổng lương của họ.
select count(magv) as 'So luong', sum(luong) as 'tong luong' from giaovien;
-- Q28. Cho biết số lượng giáo viên và lương trung bình của từng bộ môn.
select count(magv) as 'So luong', avg(luong) as 'trung binh luong', mabm from giaovien 
group by giaovien.mabm order by count(magv) ASC;
-- Q29. Cho biết tên chủ đề và số lượng đề tài thuộc về chủ đề đó.
select  count(dt.madt) as 'So luong de tai', cd.tencd from detai dt inner join chude cd 
where cd.macd = dt.macd 
group by dt.macd;
-- Q30. Cho biết tên giáo viên và số lượng đề tài mà giáo viên đó tham gia.
select gv.magv,count(dt.madt) as 'So luong de tai', gv.hoten from detai dt inner join giaovien gv
where gv.magv = dt.gvcndt
group by dt.gvcndt;
-- Q31. Cho biết tên giáo viên và số lượng đề tài mà giáo viên đó làm chủ nhiệm.
-- Q32. Với mỗi giáo viên cho tên giáo viên và số người thân của giáo viên đó.
select gv.magv, gv.hoten, count(nt.magv) as 'Số lượng người thân' from giaovien gv inner join nguoithan nt 
where nt.magv = gv.magv
group by nt.magv;
-- Q33. Cho biết tên những giáo viên đã tham gia từ 3 đề tài trở lên.
select gv.magv as 'Mã giáo viên', gv.hoten from giaovien gv inner join thamgiadt tgdt
where tgdt.magv = gv.magv
group by tgdt.magv
having count(tgdt.magv) > 3; 
-- Q34. Cho biết số lượng giáo viên đã tham gia vào đề tài Ứng dụng hóa học xanh.
select gv.magv,gv.hoten, count(tgdt.madt) as 'So luong GV tham gia đề tài Ứng dụng hóa học xanh'
from giaovien gv inner join thamgiadt tgdt on gv.magv = tgdt.magv
inner join detai dt on dt.madt = tgdt.madt
where  dt.tendt = 'Ứng dụng hóa học xanh'
group by tgdt.magv;
-- Q35. Cho biết mức lương cao nhất của các giảng viên.
select max(gv.luong) as 'Luong GV cao nhat' from giaovien gv;
-- Q36. Cho biết những giáo viên có lương lớn nhất.
select magv,hoten,luong from giaovien where luong = all(select max(luong) from giaovien);
-- Q37. Cho biết lương cao nhất trong bộ môn “HTTT”.
select magv, luong, hoten from giaovien 
inner join bomon on giaovien.mabm = bomon.mabm 
where bomon.mabm ='HTTT' and luong = all(select max(luong) from giaovien);
-- Q38. Cho biết tên giáo viên lớn tuổi nhất của bộ môn Hệ thống thông tin.
select magv, hoten from giaovien 
where  ngsinh = all(select min(ngsinh) from giaovien inner join bomon on bomon.mabm = giaovien.mabm where bomon.tenbm = 'Hệ thống thông tin' );
-- Q39. Cho biết tên giáo viên nhỏ tuổi nhất khoa Công nghệ thông tin.
select magv, hoten from giaovien 
where  ngsinh = all
(select max(ngsinh) from giaovien inner join bomon on bomon.mabm = giaovien.mabm inner join khoa on khoa.makhoa = bomon.makhoa where khoa.tenkhoa = 'Công nghệ thông tin');
-- Q40. Cho biết tên giáo viên và tên khoa của giáo viên có lương cao nhất.
select gv.magv,gv.hoten, k.tenkhoa from giaovien gv 
inner join bomon bm on bm.mabm = gv.mabm
inner join khoa k on k.makhoa = bm.makhoa where luong = all (select max(gv1.luong) from giaovien gv1);
-- Q41. Cho biết những giáo viên có lương lớn nhất trong bộ môn của họ.
select gv1.magv, gv1.hoten, gv1.luong from giaovien gv1 where luong = any(select max(gv.luong) from giaovien gv group by mabm);
-- Q42. Cho biết tên những đề tài mà giáo viên Nguyễn Hoài An chưa tham gia.
select distinct dt.tendt,dt.madt from detai dt left join thamgiadt tgdt on tgdt.madt = dt.madt
where dt.madt <> (select distinct tgdt1.madt from thamgiadt tgdt1 inner join giaovien gv1 on gv1.magv = tgdt1.magv where gv1.hoten = 'nguyen hoai an');
-- Q43. Cho biết những đề tài mà giáo viên Nguyễn Hoài An chưa tham gia. Xuất ra tên đề tài, tên người chủ nhiệm đề tài.
select distinct dt.madt, dt.tendt, gv1.hoten  from detai dt inner join giaovien gv1 on gv1.magv = dt.gvcndt
where dt.madt <> (select distinct tgdt.madt from thamgiadt tgdt inner join giaovien gv on gv.magv = tgdt.magv where gv.hoten = 'nguyen hoai an');
-- Q44. Cho biết tên những giáo viên khoa Công nghệ thông tin mà chưa tham gia đề tài nào.
 -- giaos vien khoa coong nghe thong tin
select gv.magv,gv.hoten from giaovien gv inner join bomon bm on gv.mabm = bm.mabm
inner join khoa k on bm.makhoa = k.makhoa where k.tenkhoa = 'Công nghệ thông tin';
-- sai not in co nghia la khong co trong...()
select gv3.magv, gv3.hoten from giaovien gv3
where gv3.magv not in (select tgdt.magv from thamgiadt tgdt 
where tgdt.magv = any(select gv.magv from giaovien gv inner join bomon bm on gv.mabm = bm.mabm
inner join khoa k on bm.makhoa = k.makhoa where k.tenkhoa = 'Công nghệ thông tin' ));
-- Q45. Tìm những giáo viên không tham gia bất kỳ đề tài nào
select gv3.magv, gv3.hoten from giaovien gv3
where gv3.magv not in (select tgdt.magv from thamgiadt tgdt);
-- Q46. Cho biết giáo viên có lương lớn hơn lương của giáo viên “Nguyễn Hoài An”
select gv3.magv, gv3.hoten from giaovien gv3
where gv3.luong > (select gv.luong from  giaovien gv where gv.hoten = 'Nguyễn Hoài An');
-- Q47. Tìm những trưởng bộ môn tham gia tối thiểu 1 đề tài
select gv3.magv, gv3.hoten from giaovien gv3
where gv3.magv = any(select bm.truongbm from bomon bm 
where bm.truongbm in (select tgdt.magv from thamgiadt tgdt));
-- Q48. Tìm giáo viên trùng tên và cùng giới tính với giáo viên khác trong cùng bộ môn
select distinct  gv2.magv,gv2.hoten from giaovien gv2 inner join giaovien gv1 on gv1.magv =  gv2.magv 
where (gv1.phai = gv2.phai and gv1.mabm = gv2.mabm and gv1.hoten = gv2.hoten);
-- Q49. Tìm những giáo viên có lương lớn hơn lương của ít nhất một giáo viên bộ môn “Hệ thống thông tin”
select gv3.magv, gv3.hoten from giaovien gv3 
where gv3.luong > any (select gv2.luong from giaovien gv2 
where gv2.mabm = (select bm.mabm from bomon bm where bm.tenbm = 'Hệ thống thông tin'));
-- Q50. Tìm những giáo viên có lương lớn hơn lương của tất cả giáo viên thuộc bộ môn “Hệ thống thông tin”
select gv3.magv, gv3.hoten from giaovien gv3 
where gv3.luong > all (select gv2.luong from giaovien gv2 
where gv2.mabm = (select bm.mabm from bomon bm where bm.tenbm = 'Hệ thống thông tin'));	
-- Q51. Cho biết tên khoa có đông giáo viên nhất
select count(gv.magv) as 'Số lượng giáo viên trong khoa', bm.makhoa, k.tenkhoa as 'Tên khoa'
from giaovien gv inner join bomon bm on gv.mabm = bm.mabm
inner join khoa k on bm.makhoa = k.makhoa
group by bm.makhoa order by count(gv.magv) desc limit 1;
-- Q52. Cho biết họ tên giáo viên chủ nhiệm nhiều đề tài nhất
--
--






