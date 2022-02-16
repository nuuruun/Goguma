create or replace Trigger trgCommunityDel
    before 
    delete on tblCommunity
for each row
begin
    delete from tblComcomment where community_seq = :old.community_seq;
    delete from tblCommunityImage where community_seq = :old.community_seq;
end;

create or replace Trigger Trgreview
after insert on tbldeal
for each row
begin
insert into tblReview values ('S',:NEW.deal_seq, 10,'null');
insert into tblReview values ('B',:NEW.deal_seq, 10,'null');
commit;
end;

--공지사항 이미지 삭제 후 공지사항 삭제 트리거
create or replace Trigger noticedel_img
before delete on tblnotice
for each row
begin
delete from tblnoticeImg where notice_seq = :old.notice_seq;
end;

--문의 사항 답변 삭제후 문의사항 삭제 트리거
create or replace Trigger questiondel_qaa
before delete on tblquestion
for each row
begin
delete from tblquestionandanswer where question_seq = :old.question_seq;
end;

--문의 사항 이미지 삭제후 문의사항 삭제 트리거
create or replace Trigger questiondel_img
before delete on tblquestion
for each row
begin
delete from tblquestionImg where question_seq = :old.question_seq;
end;