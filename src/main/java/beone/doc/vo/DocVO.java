package beone.doc.vo;

public class DocVO {

	private int docNo;
	private String docType;
	private String issueDate;
	private String docOriName;
	private String docSaveName;
	private String uploader;
	private long docSize;
	private String uldDate;
	private String bizrNo;
	public int getDocNo() {
		return docNo;
	}
	public void setDocNo(int docNo) {
		this.docNo = docNo;
	}
	public String getDocType() {
		return docType;
	}
	public void setDocType(String docType) {
		this.docType = docType;
	}
	public String getissueDate() {
		return issueDate;
	}
	public void setissueDate(String issueDate) {
		this.issueDate = issueDate;
	}
	public String getDocOriName() {
		return docOriName;
	}
	public void setDocOriName(String docOriName) {
		this.docOriName = docOriName;
	}
	public String getDocSaveName() {
		return docSaveName;
	}
	public void setDocSaveName(String docSaveName) {
		this.docSaveName = docSaveName;
	}
	public String getUploader() {
		return uploader;
	}
	public void setUploader(String uploader) {
		this.uploader = uploader;
	}
	public long getDocSize() {
		return docSize;
	}
	public void setDocSize(long docSize) {
		this.docSize = docSize;
	}
	public String getUldDate() {
		return uldDate;
	}
	public void setUldDate(String uldDate) {
		this.uldDate = uldDate;
	}
	public String getBizrNo() {
		return bizrNo;
	}
	public void setBizrNo(String bizrNo) {
		this.bizrNo = bizrNo;
	}
	@Override
	public String toString() {
		return "DocVO [docNo=" + docNo + ", docType=" + docType + ", issueDate=" + issueDate + ", docOriName=" + docOriName
				+ ", docSaveName=" + docSaveName + ", uploader=" + uploader + ", docSize=" + docSize + ", uldDate="
				+ uldDate + ", bizrNo=" + bizrNo + "]";
	}
	
	
}
