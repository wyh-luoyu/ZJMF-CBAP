{include file="header"}
<!-- =======内容区域======= -->
<link rel="stylesheet" href="/{$template_catalog}/template/{$themes}/css/addon.css">
<!-- =======内容区域======= -->
<div id="content" class="addon table" v-cloak>
  <t-card class="list-card-container">
    <div class="common-header">
      <a href="https://market.idcsmart.com/shop/" target="_blank">
        <t-button class="add">
          {{lang.more_plugins}}
        </t-button>
      </a>
      <div class="com-search">
        <t-input v-model="params.keywords" class="search-input" :placeholder="`${lang.please_search}${lang.plug_name}`" @keyup.enter.native="seacrh" :on-clear="clearKey" clearable>
        </t-input>
        <t-icon size="20px" name="search" @click="seacrh" class="com-search-btn" />
      </div>
    </div>
    <t-table row-key="id" :data="data" size="medium" :columns="columns" :hover="hover" :loading="loading" :table-layout="tableLayout ? 'auto' : 'fixed'" @sort-change="sortChange" display-type="fixed-width" :hide-sort-tips="true" :max-height="maxHeight">
      <template slot="sortIcon">
        <t-icon name="caret-down-small"></t-icon>
      </template>
      <template #status="{row}">
        <t-tag theme="success" class="com-status" v-if="row.status === 1" variant="light">{{lang.enable}}</t-tag>
        <t-tag theme="danger" class="com-status" v-else-if="row.status === 0" variant="light">{{lang.deactivate}}</t-tag>
        <t-tag class="com-status" v-else variant="light">{{lang.not_install}}</t-tag>
      </template>
      <template #op="{row}">
        <t-tooltip :content="enableTitle(row.status)" :show-arrow="false" theme="light">
          <a class="common-look" @click="changeStatus(row)" v-if="row.status !== 3">
            <img v-if="row.status === 0" :src='`${urlPath}/img/icon/enable.png`' alt="">
            <img v-else-if="row.status === 1" :src='`${urlPath}/img/icon/disable.png`' alt="">
          </a>
        </t-tooltip>
        <t-tooltip :content="installTitle(row.status)" :show-arrow="false" theme="light">
          <a class="common-look" @click="installHandler(row)">
            <img v-if="row.status === 3" :src='`${urlPath}/img/icon/install.png`' alt="">
            <img v-else-if="row.status !== 3" :src='`${urlPath}/img/icon/uninstall.png`' alt="">
          </a>
        </t-tooltip>
      </template>
    </t-table>
    <!-- <t-pagination :total="total" :page-size="params.limit" :current="params.page"
      :page-size-options="pageSizeOptions" @change="changePage" /> -->
  </t-card>

  <!-- 卸载/安装 -->
  <t-dialog theme="warning" :header="installTip" :visible.sync="delVisible">
    <template slot="footer">
      <t-button theme="primary" @click="sureDel">{{lang.sure}}</t-button>
      <t-button theme="default" @click="cancelDel">{{lang.cancel}}</t-button>
    </template>
  </t-dialog>

  <!-- 启用/停用 -->
  <t-dialog theme="warning" :header="statusTip" :visible.sync="statusVisble">
    <template slot="footer">
      <t-button theme="primary" @click="sureChange">{{lang.sure}}</t-button>
      <t-button theme="default" @click="closeDialog">{{lang.cancel}}</t-button>
    </template>
  </t-dialog>
</div>
<!-- =======页面独有======= -->
<script src="/{$template_catalog}/template/{$themes}/api/addon.js"></script>
<script src="/{$template_catalog}/template/{$themes}/js/addon.js"></script>
{include file="footer"}