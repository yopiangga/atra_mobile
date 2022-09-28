part of 'services.dart';

class ProsaServices {
  static Future<String> retriveTTS({http.Client client, job_id}) async {
    String url =
        "https://api.prosa.ai/v2/speech/tts/" + job_id + "?as_signed_url=true";

    client ??= http.Client();

    var response = await client.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-api-key':
            'eyJhbGciOiJSUzI1NiIsImtpZCI6Ik5XSTBNemRsTXprdE5tSmtNaTAwTTJZMkxXSTNaamN0T1dVMU5URmxObVF4Wm1KaSIsInR5cCI6IkpXVCJ9.eyJhcHBsaWNhdGlvbl9pZCI6NzczNjcsImxpY2Vuc2Vfa2V5IjoiOWU3MWE4YTEtYzVjZC00NDg0LWJhYTgtNjZjYmViYmM5Njc5IiwidW5pcXVlX2tleSI6ImYzMjJmODIyLWI3ZjItNGI5YS1iZTJlLTE4MDRiOTM4ZGM1MCIsInByb2R1Y3RfaWQiOjMsImF1ZCI6ImFwaS1zZXJ2aWNlIiwic3ViIjoiMzcwYTczN2YtOGQ0OS00YTE5LWI1YTctYzNiMjMxZTVhYWMwIiwiZXhwIjoxNjkwOTQ5MTQ1LCJpc3MiOiJjb25zb2xlIiwiaWF0IjoxNjU5NDEzMTQ1fQ.dIPG4dLokY0503Q_eEeDPrBgOhertPPzpvAqVnudDgFjdycIg1wRvWUAiQ7jgpOJrxtoU7ieD_quLGTFhBMhGMpsTDH3WI7Pb-ssiGpRYhnw0ObXjQubPbVcwt7Om0i7xr-37mWdudRuzo0t5zrT2J3Ho7f-anIgKe2AQD1Z3-wFXjEFyyBH6O49TVkLdNpqKX3FXboUgUukW-Slf9rbfVSiexujiPfBQV0D4ppZt3SP6QYSNZ7kNkTywNhIvqMCXZp-Tb1-zNubrWXyhej4w2WA1FOqox3EILk2wNchbAbVjUI3D-8wNg3cIKtYjIRiWPw-g5WEb5TDjDDAPqUIbA'
      },
    );

    if (response.statusCode != 200) {
      return "";
    }

    final res = json.decode(response.body);

    if (res == null || res['result'] == null) {
      {
        return "";
      }
    }

    var data = res['result']['path'];
    return data;
  }

  static Future<http.Response> submitTTS(List<String> texts) async {
    String url = "https://api.prosa.ai/v2/speech/tts";

    String dataText = texts.join('\\');

    dynamic data = jsonEncode({
      "config": {
        "engine": "tts-dimas-formal",
        "wait": false,
        "pitch": 0,
        "tempo": 1,
        "audio_format": "opus"
      },
      "request": {"label": "string", "text": dataText}
    });

    return http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-api-key':
              'eyJhbGciOiJSUzI1NiIsImtpZCI6Ik5XSTBNemRsTXprdE5tSmtNaTAwTTJZMkxXSTNaamN0T1dVMU5URmxObVF4Wm1KaSIsInR5cCI6IkpXVCJ9.eyJhcHBsaWNhdGlvbl9pZCI6NzczNjcsImxpY2Vuc2Vfa2V5IjoiOWU3MWE4YTEtYzVjZC00NDg0LWJhYTgtNjZjYmViYmM5Njc5IiwidW5pcXVlX2tleSI6ImYzMjJmODIyLWI3ZjItNGI5YS1iZTJlLTE4MDRiOTM4ZGM1MCIsInByb2R1Y3RfaWQiOjMsImF1ZCI6ImFwaS1zZXJ2aWNlIiwic3ViIjoiMzcwYTczN2YtOGQ0OS00YTE5LWI1YTctYzNiMjMxZTVhYWMwIiwiZXhwIjoxNjkwOTQ5MTQ1LCJpc3MiOiJjb25zb2xlIiwiaWF0IjoxNjU5NDEzMTQ1fQ.dIPG4dLokY0503Q_eEeDPrBgOhertPPzpvAqVnudDgFjdycIg1wRvWUAiQ7jgpOJrxtoU7ieD_quLGTFhBMhGMpsTDH3WI7Pb-ssiGpRYhnw0ObXjQubPbVcwt7Om0i7xr-37mWdudRuzo0t5zrT2J3Ho7f-anIgKe2AQD1Z3-wFXjEFyyBH6O49TVkLdNpqKX3FXboUgUukW-Slf9rbfVSiexujiPfBQV0D4ppZt3SP6QYSNZ7kNkTywNhIvqMCXZp-Tb1-zNubrWXyhej4w2WA1FOqox3EILk2wNchbAbVjUI3D-8wNg3cIKtYjIRiWPw-g5WEb5TDjDDAPqUIbA'
        },
        body: data);
  }
}
