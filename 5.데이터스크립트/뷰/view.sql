create or replace view vwSellerRate
as
select
    u.id id,                        --판매자 아이디
    round(avg(r.score),1) as score  --평가 받은 점수
from tblUser u
    inner join tblProduct p on p.id = u.id
    inner join tblDeal d on d.product_seq = p.product_seq
    inner join tblReview r on r.deal_seq = d.deal_seq
where r.type = 'B'
group by u.id;
    
create or replace view vwBuyerRate
as
select 
    u.id as id,                     --구매자 아이디
    round(avg(r.score), 1) as score --평가 받은 점수
from tblUser u
    inner join tblDeal d on d.id = u.id
    inner join tblReview r on r.deal_seq = d.deal_seq
where r.type = 'S'
group by u.id;

create or replace view vwUserAll
as
select 
    u.id as id,
    u.password as password,
    u.user_level as lv,
    ui.name as name,
    up.nickname as nickname,
    ui.tel as tel,
    ui.email as email,
    a.sido || ' ' || a.sgg || ' ' || a.emd || ' ' || ui.address as address,
    ui.birth as birth,
    ui.since as since,
    (nvl(sr.score, -1) + nvl(br.score, -1))/2 as score,
    up.path as path,
    CASE 
        WHEN b.id is not null THEN '차단'
        WHEN w.id is not null THEN '탈퇴'
        ELSE '정상'
    END as state
from tblUser u
    inner join tblUserInfo ui on ui.id = u.id
    left outer join tblUserProfile up on up.id = ui.id
    left outer join tblAddress a on a.address_seq = ui.address_seq
    left outer join vwSellerRate sr on sr.id = u.id
    left outer join vwBuyerRate br on br.id = u.id
    left outer join tblBlock b on b.id = u.id
    left outer join tblWithdraw w on w.id = u.id;

create or replace view vwBlock
as
select 
    b.id as id,
    ui.name as name,
    b.regdate as regdate,
    bt.type as type
from tblBlock b
    inner join tblBlockType bt on bt.block_type_seq = b.block_type_seq
    inner join tblUserInfo ui on ui.id = b.id;


create or replace view vwWithdraw
as
select 
    w.id as id,
    ui.name as name,
    w.time as regdate,
    wt.type as type
from tblWithdraw w
    inner join tblWithdrawType wt on wt.withdraw_type_seq = w.withdraw_type_seq
    inner join tblUserInfo ui on ui.id = w.id;


create or replace view vwQuestion
as
select 
    q.question_seq,
    q.id,
    qt.type,
    q.title,
    q.regdate,
    qna.question_seq as answer_seq
from tblquestion q
    left outer join tblQuestionAndAnswer qna on qna.question_seq = q.question_seq
    inner join tblQuestionType qt on qt.question_type_seq = q.question_type_seq;


CREATE OR REPLACE VIEW VWPRODUCTSOLD
AS 
select --판매한상품
tblproduct.product_seq 
,'['||tblproduct.name||']'||tblproduct.content as content
, tbluserprofile.nickname
, tblproduct.id as id
, tbldeal.id as buyid
, tbldeal.deal_seq
, tbldeal.REGDATE
from tblproduct 
inner join tbldeal on tblproduct.product_seq = tbldeal.product_seq
inner join tbluserprofile on tbluserprofile.id = tblproduct.id order by REGDATE;


CREATE OR REPLACE VIEW VWPURCHASEDPRODUCT
AS 
select --구매완료된 상품 
tblproduct.product_seq 
,'['||tblproduct.name||']'||tblproduct.content as content
, tbluserprofile.nickname
, tbldeal.id as id
, tblproduct.id as selid
, tbldeal.deal_seq
, tbldeal.REGDATE
from tblproduct 
inner join tbldeal on tblproduct.product_seq = tbldeal.product_seq
inner join tbluserprofile on tbluserprofile.id = tblproduct.id;


CREATE OR REPLACE VIEW VWRECEIVED_BUYER_REVIEWS
AS 
select -- buyid 와 userid를 매칭하면 user가 물건 구매 후 판매자에게 받은 후기를 확인할 수 있음.
    tblproduct.PRODUCT_SEQ
    ,tbldeal.id as buyid
    ,tblproduct.id as selid
    ,'[ 제목 : '||tblproduct.name||']'|| tblproduct.content as productcontent
    ,tbldeal.regdate 
    ,tblreview.score 
    ,tblreview.content as reviewcontent
from tbldeal 
    inner join tblreview on tblreview.deal_seq = tbldeal.deal_seq
    inner join tblproduct on tblproduct.product_seq = tbldeal.product_seq
where tblreview.type='S';


CREATE OR REPLACE VIEW VWRECEIVED_SELLER_REVIEWS
    AS 
select --selid와 userid랑 매칭하면 user가 물건 판매 후 구매자에게 받은 후기를 확인할 수 있음.
    tblproduct.PRODUCT_SEQ
    ,tblproduct.id as selId
    ,tbldeal.id as buyid
    ,'[ 제목 : '||tblproduct.name||']'|| tblproduct.content as productcontent
    ,tbldeal.regdate 
    ,tblreview.score 
    ,tblreview.content as reviewcontent
from tblproduct
        inner join tbldeal on tblproduct.product_seq = tbldeal.product_seq
        inner join tblreview on tblreview.DEAL_SEQ = tbldeal.DEAL_SEQ
where tblreview.type = 'B';

CREATE OR REPLACE VIEW TBLNOTICEANDIMG AS 
select a.NOTICE_SEQ ,a.TITLE, a.CONTENT, a.REGDATE, b.path from tblnotice a
left outer join tblnoticeimg b on a.notice_seq = b.notice_seq;

CREATE OR REPLACE VIEW VWFAVPRODUCT AS 
select a.favorite_seq, a.id as favid, b.id, b.regdate, b.name, b.price, b.is_auction, b.product_seq from tblfavorite a
left outer join tblproduct b on a.product_seq = b.product_seq;

CREATE OR REPLACE VIEW VWQUESTIONANDIMG AS 
select a.QUESTION_SEQ, a.ID, a.QUESTION_TYPE_SEQ, a.TITLE, a.CONTENT, a.REGDATE, b.path from tblquestion a
left outer join tblquestionimg b on a.question_seq = b.question_seq;

create or replace view vwNewProduct
as
select
    p.*,
    pi.path as img_path,
    (sysdate - regdate) as interval
from tblProduct p inner join tblProductImage pi
on (p.product_seq = pi.product_seq)
where is_completion = 'n';

create or replace view vwComComment
as
select
    cc.*,
    up.nickname,
    (sysdate - regdate) as isnew
from tblComComment cc inner join tblUser u
    on (cc.id = u.id) inner join tblUserProfile up
    on (u.id = up.id);

create or replace view vwCommunity
as
select
    c.*,
    up.nickname,
    up.path as path,
    ci.path as img_path,
    (sysdate - regdate) as isnew,
    (select count(*) from tblComComment where community_seq = c.community_seq) as commentCount
from tblCommunity c inner join tblUser u
    on (c.id = u.id) inner join tblUserProfile up
    on (u.id = up.id) inner join tblCommunityImage ci
    on (c.community_seq = ci.community_seq);
            
create or replace view vwMessage
as
select
    m.*,
    su.nickname as sender_nickname,
    ru.nickname as receiver_nickname,
    (sysdate - sendtime) as isNew
from tblMessage m inner join tblUserProfile su
    on (m.sender_id = su.id) inner join tblUserProfile ru
    on (m.receiver_id = ru.id);
