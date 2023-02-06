<link rel="stylesheet" href="/plugins/addon/idcsmart_withdraw/template/admin/css/withdrawal.css" />
<!-- =======内容区域======= -->

<div id="content" class="withdrawal" v-cloak>
  <t-card class="list-card-container">
    <ul class="common-tab">
      <li class="active">
        <a href="javascript:;">{{lang.applicat_list}}</a>
      </li>
      <li>
        <a href="balance_withdrawal_settings.html">{{lang.balance_withdrawal_settings}}</a>
      </li>
      <li>
        <a href="withdrawal_setting.html">{{lang.withdrawal_setting}}</a>
      </li>
    </ul>
    <div class="common-header">
      <p></p>
      <div class="r-box">
        <t-select v-model="params.status" :placeholder="lang.select+lang.status" :popup-props="popupProps" @change="seacrh" clearable>
          <t-option :value="0" :label="lang.to_audit">{{lang.to_audit}}</t-option>
          <t-option :value="1" :label="lang.approved">{{lang.approved}}</t-option>
          <t-option :value="2" :label="lang.approved_reject">{{lang.approved_reject}}</t-option>
        </t-select>
        <div class="com-search">
          <t-input v-model="params.keywords" class="search-input" :placeholder="`${lang.please_search}${lang.proposer}`" @keyup.enter.native="seacrh" :on-clear="clearKey" clearable>
          </t-input>
          <t-icon size="20px" name="search" @click="seacrh" class="com-search-btn" />
        </div>
      </div>
    </div>
    <t-table row-key="1" :data="data" size="medium" :columns="columns" :hover="hover" 
    :loading="loading" :table-layout="tableLayout ? 'auto' : 'fixed'" @sort-change="sortChange"
     :hide-sort-tips="hideSortTips">
      <template slot="sortIcon">
        <t-icon name="caret-down-small"></t-icon>
      </template>
      <template #phone="{row}">
        <span v-if="row.phone">+{{row.phone_code}}&nbsp;-&nbsp;{{row.phone}}</span>
      </template>
      <template #status="{row}">
        <t-tag theme="warning" class="status" v-if="row.status===0" variant="light">{{lang.to_audit}}</t-tag>
        <t-tag theme="success" class="status" v-if="row.status===1" variant="light">{{lang.approved}}</t-tag>
        <t-tooltip :content="row.reason" :show-arrow="false" theme="light" placement="top-right" v-if="row.status===2">
          <t-tag theme="danger" class="status" variant="light">{{lang.approved_reject}}
          </t-tag>
        </t-tooltip>
        <t-tag theme="success" class="status" v-if="row.status===3" variant="light">{{lang.confirmed}}</t-tag>
      </template>
      <template #withdraw_amount="{row}">
        {{currency_prefix}}{{row.withdraw_amount}}
      </template>
      <template #amount="{row}">
        {{currency_prefix}}{{row.amount}}
      </template>
      <template #username="{row}">
        <a class="jump" @click="jumpUser(row)" style="cursor: pointer;">{{row.username}}</a>
      </template>
      <template #create_time="{row}">
        {{row.create_time ? moment(row.create_time * 1000).format('YYYY-MM-DD HH:mm') : ''}}
      </template>
      <template #op="{row}">
        <t-tooltip :content="lang.pass" :show-arrow="false" theme="light">
          <t-icon name="check-circle" class="common-look" @click="passHandler(row)" v-if="row.status === 0">
          </t-icon>
        </t-tooltip>
        <t-tooltip :content="lang.reject" :show-arrow="false" theme="light">
          <t-icon name="file-excel" class="common-look" @click="rejectHandler(row)" v-if="row.status === 0">
          </t-icon>
        </t-tooltip>
        <!-- 确认已汇款 -->
        <t-tooltip :content="lang.confirm_remittance" :show-arrow="false" theme="light">
          <span class="common-look" @click="confirmRemittance(row)" v-if="row.status === 1">
            <img :src="`${baseUrl}img/icon/remittance.png`" alt="">
          </span>
        </t-tooltip>
        <!-- 修改状态 -->
        <t-tooltip :content="lang.update" :show-arrow="false" theme="light">
          <t-icon name="edit-1" class="common-look" @click="editStatus(row)" v-if="row.status === 2">
          </t-icon>
        </t-tooltip>
        <!-- 修改流水号 -->
        <t-tooltip :content="lang.edit" :show-arrow="false" theme="light">
          <t-icon name="edit-1" class="common-look" @click="confirmRemittance(row)" v-if="row.status === 3">
          </t-icon>
        </t-tooltip>
      </template>
    </t-table>
    <t-pagination :total="total" :page-size="params.limit" :page-size-options="pageSizeOptions" :on-change="changePage" :current="params.page" v-if="total" />
  </t-card>

  <!-- 驳回 -->
  <t-dialog :visible.sync="visible" :header="addTip" :on-close="close" :footer="false" width="600">
    <t-form :rules="rules" :data="formData" ref="userDialog" @submit="onSubmit" v-if="visible">
      <t-form-item :label="lang.dismiss_the_reason" name="reason">
        <t-select v-model="formData.reason" :placeholder="lang.select + lang.dismiss_the_reason">
          <t-option v-for="item in reasons" :value="item.id" :label="item.reason" :key="item.value">
          </t-option>
        </t-select>
      </t-form-item>
      <t-form-item label="" name="custom" v-if="formData.reason === 0">
        <t-textarea :placeholder="lang.dismiss_the_reason" v-model="formData.custom" />
      </t-form-item>
      <div class="f-btn">
        <t-button theme="primary" type="submit">{{lang.hold}}</t-button>
        <t-button theme="default" variant="base" @click="close">{{lang.cancel}}</t-button>
      </div>
    </t-form>
  </t-dialog>
  <!-- 驳回状态修改状态 -->
  <t-dialog :visible.sync="changeVisble" :header="lang.update + lang.status" :on-close="close" :footer="false" width="400">
    <t-form ref="userDialog" @submit="onSubmitChange" label-align="left">
      <t-form-item :label="lang.status" :label-width="60">
        <t-select v-model="updateStatus" :placeholder="lang.select+lang.status" :popup-props="popupProps">
          <t-option :value="0" :label="lang.to_audit">{{lang.to_audit}}</t-option>
          <t-option :value="1" :label="lang.approved">{{lang.approved}}</t-option>
        </t-select>
      </t-form-item>
      <div class="f-btn" style="text-align: right;">
        <t-button theme="primary" type="submit">{{lang.hold}}</t-button>
        <t-button theme="default" variant="base" @click="closeChange">{{lang.cancel}}</t-button>
      </div>
    </t-form>
  </t-dialog>
  <!-- 审核通过-->
  <t-dialog theme="warning" :header="statusTip" :visible.sync="statusVisble">
    <template slot="footer">
      <t-button theme="primary" @click="sureChange">{{lang.sure}}</t-button>
      <t-button theme="default" @click="closeDialog">{{lang.cancel}}</t-button>
    </template>
  </t-dialog>
  <!-- 确认已付款 -->
  <t-dialog :visible.sync="payVisible" :header="payTit" :on-close="closePay" :footer="false" width="600" class="payDialog">
    <t-form :rules="payRules" :data="payForm" ref="payDialog" @submit="onSubmitPay" :label-width="80" v-if="payVisible">
      <t-form-item :label="lang.money">
        <p class="disabled">{{currency_prefix}}{{payForm.withdraw_amount}}</p>
      </t-form-item>
      <!-- <t-form-item :label="lang.pay_way">
        <p class="disabled">{{lang.offline_payment}}</p>
      </t-form-item> -->
      <t-form-item :label="lang.withdraw + lang.user">
        <p class="disabled">{{payForm.username}} <span v-if="payForm.company">({{payForm.company}})</span></p>
      </t-form-item>
      <t-form-item :label="lang.withdrawal_way">
        <p class="disabled">{{payForm.method}}</p>
      </t-form-item>
      <t-form-item :label="lang.name" v-if="payForm.name">
        <p class="disabled">
          {{payForm.name}}
          <input type="text" :value="payForm.name" id="name">
          <span class="copy" @click="copyHandler('name')">{{lang.copy + lang.name}}</span>
        </p>
      </t-form-item>
      <t-form-item :label="lang.withdraw + lang.acount">
        <p class="disabled">
          <template v-if="payForm.method === 'bank'">
            {{payForm.card_number}}
          </template>
          <template v-else>
            {{payForm.account}}
          </template>
          <input type="text" :value="payForm.method === 'bank' ? payForm.card_number : payForm.account" id="account">
          <span class="copy" @click="copyHandler('account')">{{lang.copy + lang.acount}}</span>
        </p>
      </t-form-item>
      <t-form-item :label="lang.flow_number" name="transaction_number">
        <t-input v-model="payForm.transaction_number"></t-input>
      </t-form-item>
      <p class="s-tip">{{lang.pay_tip}}</p>
      <div class="f-btn" style="text-align: right;">
        <t-button theme="primary" type="submit" :loading="btnLoading">{{lang.hold}}</t-button>
        <t-button theme="default" variant="base" @click="closePay">{{lang.cancel}}</t-button>
      </div>
    </t-form>
  </t-dialog>
</div>

<script src="/plugins/addon/idcsmart_withdraw/template/admin/api/withdrawal.js"></script>
<script src="/plugins/addon/idcsmart_withdraw/template/admin/js/withdrawal.js"></script>