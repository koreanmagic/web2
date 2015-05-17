
<#macro url page><#compress>
	${boardList.path}?page=${page}&list=${boardList.size}&order=${boardList.order}
</#compress></#macro>


<!-- ***************** 페이지 버튼 ***************** -->
<div class="_location tooltip-hover tooltip-target">
	
	<div class="tooltip-content _current-page">${boardList.current}</div>
	
	<#assign exists = (boardList.before?size > 0) />
	<!-- 이전으로 가기 -->
	<#if exists>
		<div class="_prev-btn">
			<a class="_prev" href="<@url boardList.current - 1 />">
				<i class="fa fa-chevron-left"></i>
			</a>
		</div>
	<#else>
		<div class="_prev-btn">
			<i class="fa fa-chevron-left"></i>
		</div>
	</#if>
	
	
	<#assign exists = (boardList.after?size > 0) />
	<!-- 다음으로 가기 -->
	<div class="_right-position">
	<#if exists>
		<div class="_next-btn">
			<a class="_next" href="<@url boardList.current + 1 />">
				<i class="fa fa-chevron-right"></i>
			</a>
		</div>
	<#else>
		<div class="_next-btn">
			<i class="fa fa-chevron-right"></i>
		</div>
	</#if>
	</div>

</div>
<!-- ***************** 페이지 버튼 ***************** -->


<div class="btn-group small list-btns">
	<button><i class="fa fa-download"></i></button>
	<a href="#"><i class="fa fa-download"></i></a>
	<button><i class="fa fa-download"></i></button>
	<button><i class="fa fa-download"></i></button>
</div>



<!-- 작업State 총괄 현황표 -->
	<div class="_item-notice fluid-line">
		
		<!-- 리스트 왼쪽 공간 -->
		<div class="left _current-info">
			
			<div class="_notice-box">
				<span class="_notice-state _img-work-notice-${requestInfo.model}"></span><br /><br />
				<span class="_img-work-today"></span><span class="_today-list-num">12</span>
			</div>
		</div>
		
		<!-- 리스트 오른쪽 공간 -->
		<div class="right">
		</div>
			
			
		<!-- 유동적으로 가로사이즈가 조정되는 부분 -->
		<div class="center">
			<ul class="_work-count">
				
				<!-- 작업 현황 -->
				<#list states as state>
				<#assign index = state_index + 1 />
				<li>
					<div class="_notice-box">
						<span class="_img-work-state-${index}"></span>
						<br />
						<a href="/admin/work/list/${index}">
							<span class="_work-count-num-${index} <#if index?string == requestInfo.model?string>_current</#if>">${state}</span>
						</a>
						<a href="/admin/work/list/${index}?today=1" class="today-count"><#if states_today[state_index] != 0>${states_today[state_index]}</#if></a>
					</div>
				</li>
				</#list>
			</ul>			
		</div>
			
	</div>


<!-- [매크로] 참고파일 -->
<#macro referFile items><#compress>
<div class="_resource" tabindex="-1">
	<span class="tooltip-target" tabindex="-1">참고</span>
	<div class="tooltip-content tooltip-fixed">
    <#list items.resourceFile as r>
      <ul>
			<li class="index">${r_index}</li>
			<li class="img"></li>
			<li class="">${r.orignalName}</li>
			<li class="">${r.uploadTime?default('')}</li>
			<li class="">${r.size}</li>
		</ul>
    </#list>
    </div>
</div>
</#compress></#macro>

<#if searchResult?has_content>
<div id="searchResult">
<span class="title">검색어: </span>
<span class="keyword">거래처</span>
</div>
</#if>

<#-- 드랍다운 작성 매크로 -->
<#macro dropdown class position><#compress>
data-ui-dropdown="${selector} ${class}" data-ui-option="${position}"
</#compress></#macro>

<#-- 배송정보 아이콘 작성 매크로 -->
<#macro delivery num><#compress>
	<#if num == 0>fa-male
	<#elseif num == 1>fa-cubes
	<#else>fa-truck
	</#if>
</#compress></#macro>


<div class="_work-container grid-10">
	
	<!-- 작업카드 루프 -->
	<#list boardList.list as v>
	<#assign selector = "[data-work-id='" + v.id + "']" />
	<div class="_work-wrap span-2" data-work-id="${v.id}" data-customer-id="${v.customer.id}" tabindex="-1">
		
		<!-- 작업 정보 컨테이너 -->
		<div class="_work tooltip-focus">
			
			<div class="delete">
				<i class="fa fa-times"></i>
			</div>
			
			<!----------------- 시안 이미지 ----------------->
			<div class="_work-img">
			</div>
			
			
			<dl class="customer-info data-row">
				<dt><img src="/img/customer-who.gif"></dt>
				<dd class="customer-name"><span class="h2" <@dropdown ".dropdown-customer" "lb"/>>${v.customer.name}</span></dd>
				<dd>
					<#if v.manager?exists>
						<span class="manager" data-info="manager" data-info-key="${v.manager.id}" data-key="manager">${v.manager.name}</span>
						<span data-key="manager.position">${v.manager.position?default('')}</span>
					<#else>
						<span class="manager" data-key="manager">담당자 없음</span>
						<span data-key="manager.position"></span>
					</#if>
				</dd>
			</dl>			
					
			
			<!----------------- 작업 부가정보 ----------------->
			<dl class="_work-controller data-row">

				<dd class="btn-group small">
					
					<button class="work-type-${v.workType.name()}" data-key="workType" <@dropdown ".dropdown-workTypes" "cb+3"/>>
						${v.workType}
					</button> 
					
					<button class="fa <@delivery num=v.delivery.ordinal() />" data-key="delivery" data-editor="4" alt="${v.delivery}" data-ui-tooltip="lt-3"></button>
					
					<!-- 메모 -->
					<button class="fa fa-pencil-square-o btn-memo<#if !v.memo?has_content> disable</#if>" <@dropdown "[data-key='memo']" "lb+4"/> alt="메모" data-ui-tooltip="lt-3">
					</button>

					<!-- 참고파일 -->
					<button class="fa fa-folder-open _pop-file-refer disable" alt="참고파일" data-ui-tooltip="lt-3" data-editor="3">
						<#-- <span class="size">12</span> -->
					</button>
					
					<!-- 인쇄 -->
					<button class="fa fa-floppy-o" alt="인쇄파일" data-ui-tooltip="lt-3" <@dropdown ".work-file" "lb+4" />>
						<#-- <span class="size">12</span> -->
					</button>
										
				</dd>
				
				<dd class="_state-select">
						<span tabindex="-1" <@dropdown ".dropdown-state" "rb"/>>${v.workState.name} <i class="fa fa-caret-down"></i></span>
				</dd>
			</dl>
			
			
			<#if (.now?long - v.insertTime?long) < (1000*60*60*24)> <#-- 딱 하루 -->
				<span class="today-work"><i class="fa fa-plus-circle"></i></span>
			</#if>
			

			
			<!----------------- 작업 세부정보 ----------------->
			<dl class="data-row _item">
				<dt></dt>
				<dd>
					<span data-key="item" data-info="work" data-info-key="${v.id}">${v.item?default('')}</span></dd>
			</dl>
			
			<dl class="data-row _item-detail">
				<dt></dt>
				<dd>
					<span data-key="itemDetail">${v.itemDetail?default('')}</span>
					<i class="item-tag fa fa-tags<#if !v.afterProcess?has_content> ui-helper-hidden</#if>" <@dropdown "[data-key='afterProcess']" "lb+3"/> alt="후가공" data-ui-tooltip="lt-3"></i>
				</dd>
			</dl>
			
			
			
			<dl class="data-row">
				<dt>크기</dt>
				<dd>
					<span data-key="size" data-editor="0">${v.size?default('')}</span>
				</dd>
			</dl>
			<dl class="data-row">
				<dt>수량</dt>
				<dd>
					<span data-key="count">${v.count?default('')}</span>
				</dd>
			</dl>
			<dl class="data-row _price">
				<dt>금액</dt>
				<dd>
					<span data-key="price">${v.price?default('')}</span>
				</dd>
			</dl>
			
			
			
			<!----------------- 기타정보 ----------------->
			<dl class="data-row">
				<dt data-key="insertTime">${v.insertTime?string('yyyy-MM-dd HH:mm')}</dt>
				<dd class="right">
					<span data-key="subcontractor" <@dropdown ".dropdown-subcontractor" "rb" />>${v.subcontractor.name}</span>
				</dd>
			</dl>
			
			
			<!----------------- 툴팁 ----------------->
			<ul class="ui-helper-hidden drop-box menu dropdown-subcontractor">
  				<li><a href="/admin/work/list/${v.workState.id}/subcontractor/${v.subcontractor.id}">하청업체 검색</a></li>
  				<li><a href="#" data-popup=".info-subcontractor" data-info="subcontractor" data-info-key="${v.subcontractor.id}">하청업체 정보</a></li>
  			</ul>	
			
			<ul class="ui-helper-hidden drop-box menu dropdown-customer">
				<li><a href="/admin/work/list/${v.workState.id}/customer/${v.customer.id}">거래처 검색</a></li>
				<li><a href="/admin/work/insert/${v.customer.id}">작업 등록</a></li>
				<li><a href="#" data-info="customer" data-info-key="${v.customer.id}">거래처 정보</a></li>
			</ul>
			
			<ul class="ui-helper-hidden drop-box menu dropdown-state">
				<#list workStates as w>
				<#if v.workState.id != w.id>
					<li><a href="/admin/work/set/state/${v.id}/${w.id}">${w.name}</a></li>
				</#if>
				</#list>
			</ul>
			
			<ul class="ui-helper-hidden drop-box menu dropdown-workTypes">
				<#list workTypes as w>
				<#if v.workType.ordinal() != w.ordinal()>
					<li><a href="/admin/work/set/workType/${v.id}/${w.ordinal()}">${w.type}</a></li>
				</#if>
				</#list>
			</ul>
			
			<div class="ui-helper-hidden drop-box work-file">
				<a class="zip" href="#"></a>
				<dl class="data-row">
					<dt><i class="fa fa-signal"></i></dt>
					<dd>1,245KB</dd>
				</dl>
				<dl class="data-row">
					<dt><i class="fa fa-clock-o"></i></dt>
					<dd>2015-05-16 am8:40</dd>
				</dl>
				<span>이 파일은 여러개의 파일의 묶음입니다.</span>
			</div>		
			
			<div class="drop-box" data-key="memo">
				<div class="text-box">
					<#if v.memo?has_content>${v.memo?replace("\n", "<BR />")}</#if>
				</div>
			</div>
			
			<div class="drop-box" data-key="afterProcess">
				<div class="text-box">
					<#if v.afterProcess?has_content>${v.afterProcess}</#if>
				</div>
			</div>
			
		</div>
		
	</div>
	</#list>
	
	
</div>

<#include "includes/editor.ftl" />
<#include "includes/info-table.ftl" />

<script>



</script>