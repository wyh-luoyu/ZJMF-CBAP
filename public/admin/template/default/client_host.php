{include file="header"}
<!-- =======内容区域======= -->
<div id="content" class="host table hasCrumb" v-cloak>
  <!-- crumb -->
  <div class="com-crumb">
    <span>{{lang.user_manage}}</span>
    <t-icon name="chevron-right"></t-icon>
    <a href="client.html">{{lang.user_list}}</a>
    <t-icon name="chevron-right"></t-icon>
    <span class="cur">{{lang.product_info}}</span>
  </div>
  <t-card class="list-card-container">
    <div class="com-h-box">
      <ul class="common-tab">
        <li>
          <a :href="`client_detail.html?id=${id}`">{{lang.personal}}</a>
        </li>
        <li class="active">
          <a href="javascript:;">{{lang.product_info}}</a>
        </li>
        <li>
          <a :href="`client_order.html?id=${id}`">{{lang.order_manage}}</a>
        </li>
        <li>
          <a :href="`client_transaction.html?id=${id}`">{{lang.flow}}</a>
        </li>
        <li>
          <a :href="`client_log.html?id=${id}`">{{lang.log}}</a>
        </li>
        <li>
          <a :href="`client_notice_sms.html?id=${id}`">{{lang.notice_log}}</a>
        </li>
      </ul>
      <t-select class="user" v-if="this.clientList.length>0" v-model="id" :popup-props="popupProps" filterable @change="changeUser">
        <t-option v-for="item in clientList" :value="item.id" :label="item.username?item.username:(item.phone?item.phone:item.email)" :key="item.id">
          #{{item.id}}-{{item.username ? item.username : (item.phone? item.phone: item.email)}}
          <span v-if="item.company">({{item.company}})</span>
        </t-option>
      </t-select>
    </div>
    <t-table row-key="1" :data="data" size="medium" :columns="columns" :hover="hover" :loading="loading" :table-layout="tableLayout ? 'auto' : 'fixed'" :max-height="maxHeight" :hide-sort-tips="true" @sort-change="sortChange">
      <template slot="sortIcon">
        <t-icon name="caret-down-small"></t-icon>
      </template>
      <template #id="{row}">
        <a :href="`host_detail.html?client_id=${row.client_id}&id=${row.id}`" class="aHover">{{row.id}}</a>
      </template>
      <template #product_name="{row}">
        <a :href="`host_detail.html?client_id=${row.client_id}&id=${row.id}`" class="aHover">{{row.product_name}}</a>
      </template>
      <template #amount="{row}">
        {{currency_prefix}}&nbsp;{{row.first_payment_amount}}<span v-if="row.billing_cycle">/</span>{{row.billing_cycle}}
      </template>
      <template #status="{row}">
        <t-tag theme="warning" variant="light" v-if="row.status==='Unpaid'">{{lang.Unpaid}}</t-tag>
        <t-tag theme="primary" variant="light" v-if="row.status==='Pending'">{{lang.Pending}}</t-tag>
        <t-tag theme="success" variant="light" v-if="row.status==='Active'">{{lang.Active}}</t-tag>
        <t-tag theme="danger" variant="light" v-if="row.status==='Failed'">{{lang.Failed}}</t-tag>
        <t-tag theme="default" variant="light" v-if="row.status==='Suspended'">{{lang.Suspended}}</t-tag>
        <t-tag theme="default" variant="light" v-if="row.status==='Deleted'" class="delted">{{lang.Deleted}}
        </t-tag>
      </template>
      <template #active_time="{row}">
        <span v-if="row.status !== 'Unpaid'">{{row.active_time ===0 ? '-' : moment(row.active_time * 1000).format('YYYY/MM/DD HH:mm')}}</span>
      </template>
      <template #due_time="{row}">
        <span v-if="row.status !== 'Unpaid'">{{row.due_time ===0 ? '-' : moment(row.due_time * 1000).format('YYYY/MM/DD HH:mm')}}</span>
      </template>
      <template #op="{row}">
        <a class="common-look" @click="deltePro(row)">{{lang.delete}}</a>
      </template>
    </t-table>
    <t-pagination :total="total" :page-size="params.limit" :page-size-options="pageSizeOptions" :on-change="changePage" />
  </t-card>
  <!-- 删除 -->
  <t-dialog theme="warning" :header="lang.sureDelete" :close-btn="false" :visible.sync="delVisible">
    <template slot="footer">
      <div class="common-dialog">
        <t-button @click="onConfirm">{{lang.sure}}</t-button>
        <t-button theme="default" @click="delVisible=false">{{lang.cancel}}</t-button>
      </div>
    </template>
  </t-dialog>
</div>
<script src="/{$template_catalog}/template/{$themes}/api/client.js"></script>
<script src="/{$template_catalog}/template/{$themes}/js/client_host.js"></script>
{include file="footer"}