<link rel="stylesheet" href="/plugins/addon/idcsmart_news/template/admin/css/new.css" />
<link rel="stylesheet" href="/plugins/addon/idcsmart_news/template/admin/css/common/reset.css" />
<!-- =======内容区域======= -->
<div id="content" class="help news" v-cloak>
  <t-card class="list-card-container">
    <div class="help_card">
      <div class="help_tabs flex">
        <div class="tabs flex">
          <div class="tabs_item active" @click="changetabs(1)">{{lang.order_new}}</div>
          <div class="tabs_item" @click="changetabs(3)">{{lang.classific_manage}}</div>
        </div>
        <div class="searchbar com-search">
          <t-input v-model="params.keywords" @change="onEnter" class="search-input" :placeholder="lang.search_placeholder" clearable>
          </t-input>
          <t-icon size="20px" name="search" @click="getlist(1)" class="com-search-btn" />
        </div>
        <!-- <div class="searchbar">
                  <t-input placeholder="请输入你需要搜索的内容" v-model="params.keywords" @Enter="onEnter" clearable>
                    <t-icon name="search" slot="suffixIcon" @click="getlist"></t-icon>
                  </t-input>
                </div> -->
      </div>
      <div class="help_table">
        <t-table hover row-key="index" :pagination="pagination" :loading="loading" :data="list" :columns="columns" @Change="changepages">
          <template #pushorback="slotProps">
            <t-switch v-model="slotProps.row.hidden?false:true" @change="onswitch(slotProps.row,$event)" />
          </template>
          <template #create_time="slotProps">
            <span v-if="slotProps.row.create_time" style="width: 200px;">{{
                      getLocalTime(slotProps.row.create_time)
                      }}</span>
          </template>
          <template #op="slotProps">
            <t-icon name="edit-1" color="#0052D9" style="margin-right: 10px;" @click="edit(slotProps.row.id)" class="common-look">
            </t-icon>
            <!-- <t-popconfirm theme="warning" content="确认要删除吗？" @Confirm="deletes(slotProps.row.id)">
              <t-icon name="delete" color="#0052D9" class="common-look"></t-icon>
            </t-popconfirm> -->
            <t-icon name="delete" color="#0052D9" class="common-look" @click="deletes(slotProps.row.id)"></t-icon>
          </template>
        </t-table>
      </div>
      <div class="help_pages"></div>
    </div>
  </t-card>
  <!-- 删除提示框 -->
  <t-dialog theme="warning" :header="lang.sureDelete" :close-btn="false" :visible.sync="delVisible" class="delDialog">
    <template slot="footer">
      <t-button theme="primary" @click="sureDelUser">{{lang.sure}}</t-button>
      <t-button theme="default" @click="delVisible=false">{{lang.cancel}}</t-button>
    </template>
  </t-dialog>
  <t-dialog :header="lang.news_classific_manage" placement="center" :visible.sync="visible" :on-cancel="onCancel" :on-esc-keydown="onKeydownEsc" :on-close-btn-click="onClickCloseBtn" :on-close="close" width="70%" :footer="false">
    <t-table :key="key" bordered row-key="index" :max-height="140" :data="typelist" :columns="columns2" max-height="80%">
      <template #name="slotProps">
        <t-input :placeholder="lang.input" v-model="slotProps.row.name" :disabled="!slotProps.row.isedit" style="width: 250px;" />
      </template>
      <template #time="slotProps">
        <span v-if="slotProps.row.update_time" style="width: 200px;">{{ getLocalTime(slotProps.row.update_time)
                  }}</span>
      </template>
      <template #op="slotProps">
        <div v-if="slotProps.row.id">
          <t-icon v-if="slotProps.row.isedit" name="save" color="#0052D9" style="margin-right: 10px;" @click="edithelptypeform(slotProps.row.name,slotProps.row.id)"></t-icon>
          <t-icon v-if="slotProps.row.isedit" name="close-rectangle" color="#0052D9" @click="canceledit()">
          </t-icon>
          <t-icon v-if="!slotProps.row.isedit" name="edit-1" color="#0052D9" style="margin-right: 10px;" @click="edithandleClickOp(slotProps.row.id)"></t-icon>
          <t-icon v-if="!slotProps.row.isedit" name="delete" color="#0052D9" @click="deleteClickOp(slotProps.row.id)"></t-icon>
        </div>
        <div v-else>
          <!--   <t-icon name="save" color="#0052D9" style="margin-right: 10px;" @click="savehandleClickadd(slotProps.row.name)"></t-icon> -->
          <t-icon name="close-rectangle" color="#0052D9" @click="deleteClickadd(slotProps.row.name)"></t-icon>
        </div>
      </template>
    </t-table>
    <div class="addtype" @click="addtype">{{lang.order_new}}</div>
    <div class="com-f-btn" style="text-align: center;">
      <t-button theme="primary" type="submit" @click="savehandleClickadd">{{lang.batch_add}}</t-button>
      <t-button theme="default" variant="base" @click="visible = false">{{lang.close}}</t-button>
    </div>
  </t-dialog>
</div>
<script src="/plugins/addon/idcsmart_news/template/admin/api/new.js"></script>
<script src="/plugins/addon/idcsmart_news/template/admin/js/new.js"></script>