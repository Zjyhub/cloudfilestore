package meta

import (
	mydb "cloudfilestorge/db"
)

var fileMetas map[string]FileMeta

// FileMeta 文件元信息结构
type FileMeta struct {
	FileSha1 string
	FileName string
	FileSize int64
	Location string
	UploadAt string
}

// init 初始化
func init() {
	fileMetas = make(map[string]FileMeta)
}

// UpdateFileMeta 更新文件元信息
func UpdateFileMeta(fmeta FileMeta) {
	fileMetas[fmeta.FileSha1] = fmeta
}

// UpdateFileMetaDB 更新文件元信息到数据库
func UpdateFileMetaDB(fmeta FileMeta) bool {
	return mydb.OnFileUploadFinished(
		fmeta.FileSha1, fmeta.FileName, fmeta.FileSize, fmeta.Location,
	)

}

// GetFileMeta 通过文件的sha1值获取文件的元信息
func GetFileMeta(fileSha1 string) FileMeta {
	return fileMetas[fileSha1]
}

// RemoveFileMeta 通过文件的sha1值删除文件的元信息
func RemoveFileMeta(fileSha1 string) {
	delete(fileMetas, fileSha1)
}
