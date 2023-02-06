<link rel="stylesheet" href="/plugins/addon/idcsmart_file_download/template/admin/css/file_download.css" />
<link rel="stylesheet" href="/plugins/addon/idcsmart_file_download/template/admin/css/common/reset.css" />
<!-- =======内容区域======= -->
<div id="content" class="help download" v-cloak>
  <t-card class="list-card-container">
    <div class="help_card">
      <div class="help_tabs flex">
        <div class="tabs flex">
          <div class="tabs_item active" @click="changetabs(1)">{{lang.attachment}}</div>
          <div class="tabs_item" @click="changetabs(2)">{{lang.file_move}}</div>
          <div class="tabs_item deletefiles" @click="changetabs(3)">{{lang.delete}}</div>
        </div>
        <div class="searchbar com-search">
          <t-input v-model="params.keywords" class="search-input" :placeholder="lang.search_placeholder" @change="onEnter" clearable>
          </t-input>
          <t-icon size="20px" name="search" @click="getfilelist(1)" class="com-search-btn" />
        </div>
        <!-- <div class="searchbar">
                                    <t-input placeholder="请输入你需要搜索的内容" @Enter="onEnter" @change="changeinput" clearable>
                                    </t-input>
                                    <t-icon size="20px" name="search" slot="suffixIcon" @click="getfilelist"></t-icon>
                                </div> -->
      </div>
      <div class="help_table">
        <t-table hover row-key='id' :pagination="pagination" :data="list" @Change="changepages" @select-change="rehandleSelectChange" :columns="columns" 
        :loading="loading" :selected-row-keys="selectedRowKeys">
          <template #name="slotProps">
            <t-tooltip placement="top-left" :content="slotProps.row.name" theme="light">
              <div class="filename">
                <span @click="downloadFile(slotProps.row)">
                  {{slotProps.row.name}}</span>
              </div>
            </t-tooltip>
          </template>
          <template #pushorback="slotProps">
            <t-switch v-model="slotProps.row.hidden?false:true" @change="onswitch(slotProps.row,$event)" />
          </template>
          <template #filesize="slotProps">
            <div>
              {{slotProps.row.filesize / 1024 / 1024 >= 1
                                            ? (slotProps.row.filesize / 1024 / 1024).toFixed(2) + "M"
                                            : (slotProps.row.filesize / 1024).toFixed(2) + "KB"}}
            </div>
          </template>
          <template #createtime="slotProps">
            {{ getLocalTime(slotProps.row.create_time)
                                        }}
          </template>

          <template #op="slotProps">
            <t-icon name="edit-1" color="#0052D9" style="margin-right: 10px;" @click="edit(slotProps.row.id)">
            </t-icon>
          </template>
        </t-table>
      </div>
      <div class="help_pages"></div>
    </div>
  </t-card>
  <t-card class="menucard">
    <div class="foldername">{{lang.folder}}</div>
    <!-- <div class="top-tit">
      <span class="txt" @click="changeAll">{{lang.all_files}}</span>
      <span>{{folderNum}}</span>
    </div> -->


    <!-- <t-tree :data="menudata" ref="tree" hover @click="todetialfiles">
      <template #operations="{ node }">
        <t-input v-if="node.value==nodevalue" class="nodeinput" v-model="node.data.label" :default-Value='node.data.label'>
          <img :src="`${baseUrl}img/file.png`" alt="" width="20px" class="fileIcon" :class='{active: node.data.default}' />
          <t-icon class="close-circle" name="close-circle" color="#0052D9" slot="suffixIcon" @click="deletenode(node)">
          </t-icon>
        </t-input>
        <span class="filenum">{{node.data.file_num}}</span>
        <t-icon v-if="node.value!==nodevalue" class="iconsolt" name="edit-1" color="#0052D9" style="margin-right: 5px;" @click="editfolder(node)">
        </t-icon>
        <t-icon v-if="node.value==nodevalue" name="save" class="iconsolt" color="#0052D9" style="margin-right: 5px;" @click="savefolder(node.data.label,node.data.id)">
        </t-icon>
        <t-icon v-if="node.value==nodevalue" class="iconsolt" name="close-rectangle" color="#0052D9" @click="canceledit()">
        </t-icon>
        <t-popconfirm :visible="isdelete===node.data.id" content="确认删除吗" @cancel="()=>{isdelete=''}" @Confirm="deletefolder(node,'confirm')">
          <t-icon v-if="node.value!==nodevalue" class="iconsolt" name="delete" color="#0052D9" @click="deletefolder(node)">
          </t-icon>
        </t-popconfirm>
      </template>
    </t-tree> -->

    <t-loading :loading="fileLoading" class="fileLoading">
      <div class="file-box">
        <div class="item">
          <span class="file-name" @click="changeAll" :class="{active: !this.folder_id}">{{lang.all_files}}</span>
          <span class="icon">
            {{folderNum}}
          </span>
        </div>
        <div class="item" v-for="(item,index) in menudata" :key="item.id">
          <span class="file-name" :class="{active: curIndex === index}" @click="changeFile(item,index)">
            <!-- <img :src="`${baseUrl}img/icon/file.png`" alt="" width="20px" class="fileIcon" :class='{active: item.default}' @click="changeDef(item)" /> -->
            <t-input v-if="item.edit" class="nodeinput" v-model="item.label" :default-Value='item.label'>
              <t-icon class="close-circle" name="close-circle" color="#0052D9" slot="suffixIcon" @click="deletenode(item)">
              </t-icon>
            </t-input>
            <span v-else>{{item.label}}</span>
          </span>
          <span class="icon">
            <span class="filenum">{{item.file_num}}</span>
            <t-icon v-if="!item.edit" class="iconsolt" name="edit-1" color="#0052D9" style="margin-right: 5px;" @click="editfolder(item)">
            </t-icon>
            <t-icon v-if="item.edit" name="save" class="iconsolt" color="#0052D9" style="margin-right: 5px;" @click="savefolder(item.label,item.id)">
            </t-icon>
            <t-icon v-if="item.edit" class="iconsolt" name="close-rectangle" color="#0052D9" @click="canceledit()">
            </t-icon>
            <t-popconfirm :visible="isdelete===item.id" :content="lang.sureDelete" @cancel="()=>{isdelete=''}" @Confirm="deletefolder(item,'confirm')">
              <t-icon v-if="!item.edit" class="iconsolt" name="delete" color="#0052D9" @click="deletefolder(item)">
              </t-icon>
            </t-popconfirm>
          </span>
        </div>
      </div>
    </t-loading>



    <div v-if="appendfolder" class="addfolder">
      <t-input class="nodeinput" v-model="newfolder" @keyup.enter.native="addnewfolder" autofocus>
        <t-icon class="close-circle" name="close-circle" color="#0052D9" slot="suffixIcon" @click="()=>{newfolder=''}">
        </t-icon>
      </t-input>
      <div class="iconsolt2">
        <t-icon name="save" class="iconsolt" @click="addnewfolder">
        </t-icon>
        <t-icon name="close-rectangle" class="iconsolt" @click="()=>{appendfolder=false}">
        </t-icon>
      </div>
    </div>

    <div class="addclass operations" @click="append">{{lang.add_folder}}</div>
  </t-card>
  <t-dialog :header="lang.attachment" placement="center" :visible.sync="visible" @Cancel="onCancel" :footer="false"
  @EscKeydown="onKeydownEsc" @CloseBtnClick="onClickCloseBtn" @Close="close" width="70%" @Confirm="uploadConfirm" @progress="uploadProgress">
    <div class="uploadfile">
      <t-upload :action="uploadUrl" :format-response="formatResponse" :headers="uploadHeaders" @Change="changeupload" v-model="files" allow-upload-duplicateFile="false" @progress="uploadProgress" theme="custom" multiple>
        <t-button theme="default">{{lang.attachment_file}}</t-button>
        <span>{{uploadTip}}</span>
      </t-upload>
    </div>

    <t-table :key="key" row-key="index" :data="uploadfilelist" :columns="columns2" max-height="80%" class="tableupload">
      <template #name="slotProps">
        <span :title="slotProps.row.name">{{slotProps.row.name}}</span>
      </template>
      <template #folder="slotProps">
        <t-select class="demo-select-base" v-model="slotProps.row.addon_idcsmart_file_folder_id">
          <t-option v-for="(item, index) in menudata" :label="item.name" :key="index" :value="item.id">
            {{ item.name }}
          </t-option>
        </t-select>
      </template>
      <template #product="slotProps">
        <t-select v-model="slotProps.row.product_id" class="demo-select-base" :disabled="slotProps.row.visible_range!='product'" multiple>
          <t-option v-for="(item, index) in product" :value="item.id" :label="item.name" :key="index">
            {{ item.name }}
          </t-option>
        </t-select>
      </template>
      <template #range="slotProps">
        <t-select class="demo-select-base" v-model="slotProps.row.visible_range">
          <t-option v-for="(item, index) in visible_range" :label="item.label" :key="index" :value="item.value">
            {{ item.label }}
          </t-option>
        </t-select>
      </template>
      <template #op="slotProps">
        <div>
          <t-switch v-model="slotProps.row.hidden"> </t-switch>
          <t-icon name="delete" color="#0052D9" @click="deleteupfile(slotProps.row.filename)">
          </t-icon>
        </div>
      </template>
      </template>
    </t-table>
    <div class="com-f-btn">
        <t-button theme="primary" type="submit" @click="uploadConfirm" :disabled="uploadfilelist.length === 0">{{lang.sure}}</t-button>
        <t-button theme="default" variant="base" @click="visible = false">{{lang.cancel}}</t-button>
      </div>
  </t-dialog>
  <t-dialog :header="lang.edit" placement="center" :visible.sync="showinfo" :on-cancel="onCancel" :on-esc-keydown="onKeydownEsc" :on-close-btn-click="onClickCloseBtn" :on-close="close" max-width="50%" confirm-btn='保存' @Confirm="onSubmit" :footer="false">
    <t-form :data="formData" :rules="rules" ref="form" @submit="onSubmit" v-if="formData">
      <t-form-item :label="lang.file_name" name="name">
        <t-input v-model="formData.name" placeholder="请输入文件名称"></t-input>
      </t-form-item>
      <t-form-item :label="lang.belong_file" name="folder">
        <t-select class="demo-select-base" v-model="formData.addon_idcsmart_file_folder_id">
          <t-option v-for="(item, index) in menudata" :label="item.name" :key="index" :value="item.id">
            {{ item.name }}
          </t-option>
        </t-select>
      </t-form-item>
      <t-form-item :label="lang.visible_range" name="visible_range">
        <t-select class="demo-select-base" v-model="formData.visible_range">
          <t-option v-for="(item, index) in visible_range" :label="item.label" :key="item.value" :value="item.value">
            {{ item.label }}
          </t-option>
        </t-select>
      </t-form-item>
      <t-form-item v-if="formData.visible_range==='product'" :label="lang.appoint_product" name="product_id" style="margin-bottom: 20px;">
        <t-select v-model="formData.product_id" class="demo-select-base" multiple :min-collapsed-num="1" @visible-change="blurHandler">
          <t-option v-for="(item, index) in filterOptions" :value="item.id" :label="item.name" :key="index">
            {{ item.name }}
          </t-option>
          <div slot="panelTopContent" class="custom-search">
            <t-input v-model="search" clearable :placeholder="lang.input" @change="onSearch" />
          </div>
        </t-select>
      </t-form-item>
      <div class="com-f-btn">
        <t-button theme="primary" type="submit">{{lang.hold}}</t-button>
        <t-button theme="default" variant="base" @click="showinfo = false">{{lang.cancel}}</t-button>
      </div>
    </t-form>
  </t-dialog>
  <!-- 删除弹窗 -->
  <t-dialog theme="warning" :header="lang.sureDelete" :visible.sync="visible3" @confirm="onConfirm3" :on-close="close3">
    <template slot="footer" style="text-align: right;">
      <t-button theme="primary" @click="onConfirm3">{{lang.sure}}</t-button>
      <t-button theme="default" @click="visible3=false">{{lang.cancel}}</t-button>
    </template>
  </t-dialog>

  <t-dialog :header="lang.file_move" placement="center" :visible.sync="visible4" max-width="50%" @Confirm="onSubmitmove">
    <t-form :data="moveData" :rules="rulesmove" ref="moveform">
      <t-form-item :label="lang.folder" name="addon_idcsmart_file_folder_id">
        <t-select class="demo-select-base" @change="moveChange" v-model="moveData.addon_idcsmart_file_folder_id" style="margin-bottom: 20px;">
          <t-option v-for="(item, index) in filterData" :label="item.name" :key="index" :value="item.id">
            {{ item.name }}
          </t-option>
        </t-select>
      </t-form-item>
    </t-form>
  </t-dialog>
</div>
<script src="/plugins/addon/idcsmart_file_download/template/admin/api/file_download.js"></script>
<script src="/plugins/addon/idcsmart_file_download/template/admin/js/file_download.js"></script>