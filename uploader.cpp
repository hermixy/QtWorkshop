#include "uploader.h"

#include <QDir>
#include <QDebug>

Uploader::Uploader(QObject *parent) : QObject(parent)
{
    connect(&m_nam, &QNetworkAccessManager::networkAccessibleChanged, this, &Uploader::networkAccessibleChanged);
}

bool Uploader::triggerUpload(const QString &localfilePath, QUrl url)
{
    UploadJob* up = new UploadJob( localfilePath, url);
    //m_lstJob.push_back(up);


    url.setScheme("ftp");
    url.setHost("ftp.a-team.fr");
    url.setUserName("qtworkshop@a-team.fr");
    url.setPassword("W0rksh0pQt");
    url.setPort(21);

    QNetworkRequest request(url);
    if (up->isOpen())
    {
        QNetworkReply* reply = m_nam.put(request, up->data() );

        connect(reply, &QNetworkReply::finished, up, &UploadJob::uploadFinished);
        connect(up, &UploadJob::finish, this, &Uploader::jobCompleted);
        connect(reply, &QNetworkReply::uploadProgress, up, &UploadJob::uploadProgress);
        connect(up, &UploadJob::progressed, this, &Uploader::jobProgress);

    }
    else {
        qDebug() << QString("Could not opened %1").arg(localfilePath);
        up->deleteLater();
    }
    return true;

}




UploadJob::UploadJob(const QString &localfilePath, const QUrl &url, QObject* parent):QObject(parent), m_url(url), m_localFile(localfilePath)
{

    m_isOpen = m_localFile.open(QIODevice::ReadOnly);
    QFileInfo inf (localfilePath);
    qDebug() << inf.size();
    qDebug() << inf.exists();
    if (!m_isOpen){
        QString error;
        if ( !m_localFile.exists() )
        {
            error = tr("File %1 does not exist").arg( localfilePath);
            emit failed( error);
            qDebug() << error;
        }
        else {
            error = tr("File %1 size is %2 exist").arg( localfilePath).arg(m_localFile.size());
               qDebug() <<error;
        }
    }

}

UploadJob::~UploadJob()
{
    if (m_isOpen)
        m_localFile.close();

}

void UploadJob::uploadFinished()
{
    QNetworkReply* reply = qobject_cast<QNetworkReply*>(sender());

    if (reply && reply->error() == QNetworkReply::NoError)
    {
        emit finish( m_localFile.fileName() );
        qDebug() << tr("Success uploading %1").arg( m_localFile.fileName() );
    }
    else {
        emit failed( tr("ERROR uploading file %1 with error :%2").arg( m_localFile.fileName()).arg(reply->errorString()) );
        qDebug() << reply->errorString();
    }

    reply->deleteLater();

    deleteLater();

}

void UploadJob::uploadProgress(qint64 bytesSent, qint64 bytesTotal)
{
    if (bytesTotal==0 ) return;
    emit progressed( m_localFile.fileName(), 100 * bytesSent / bytesTotal);
    qDebug() << QString("Sending %1 : %2 / %3").arg(m_localFile.fileName()).arg(bytesSent).arg(bytesTotal);

}
