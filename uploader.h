#ifndef UPLOADER_H
#define UPLOADER_H

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QFile>

class UploadJob : public QObject
{
    Q_OBJECT
public:
    UploadJob(const QString& localfilePath , const QUrl& url, QObject* parent = nullptr);
    ~UploadJob();
    bool isOpen(){ return m_isOpen;}

public slots:
    void uploadFinished();
    QIODevice* data(){ return &m_localFile;}
    void uploadProgress(qint64 bytesSent, qint64 bytesTotal);

signals :
    void finish(const QString& localFilePath);
    void failed(QString);
    void progressed( const QString& localfilePath, qint64 percProgress);

private:
    QUrl m_url;
    QFile m_localFile;
    bool m_isOpen = false;
};

class Uploader : public QObject
{
    Q_OBJECT
public:
    explicit Uploader(QObject *parent = nullptr);
    bool networkAccessible(){
        return m_nam.networkAccessible() == QNetworkAccessManager::Accessible;}

    Q_INVOKABLE QString getFileNameFromUrl(QUrl url){
        return url.fileName();
    }
    Q_INVOKABLE QString getFilePathFromUrl(QUrl url){
        return url.path();
    }
public slots:
    bool triggerUpload( const QString& localfilePath , QUrl url);

signals:
    void jobCompleted(const QString& localfilePath);
    void jobProgress(const QString& localfilePath, qint64 percProgress);
    void networkAccessibleChanged();
private:
    QNetworkAccessManager m_nam;
    std::vector<UploadJob*> m_lstJob;

    //QFile m_file;
};

#endif // UPLOADER_H
